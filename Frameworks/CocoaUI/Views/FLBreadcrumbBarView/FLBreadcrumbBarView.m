//
//  FLBreadcrumbBarView.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/29/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLBreadcrumbBarView.h"

@implementation FLBreadcrumbBarView

@synthesize breadcrumbs = _breadcrumbs;
@synthesize verticalTextAlignment = _verticalTextAlignment;
@synthesize enabledTextColor = _enabledTextColor;
@synthesize disabledTextColor = _disabledTextColor;
@synthesize highlightedTextColor = _highlightedTextColor;
@synthesize textFont = _textFont;

- (id) initWithFrame:(CGRect) frame {
    if((self = [super initWithFrame:frame])) {
        self.userInteractionEnabled = YES; 
        self.backgroundColor = [FLColor clearColor];
        _breadcrumbs = [[FLOrderedCollection alloc] init];
        
        self.backgroundColor = [FLColor whiteColor];
        self.enabledTextColor = [FLColor blackColor];
        self.disabledTextColor = [FLColor lightGrayColor];
        self.highlightedTextColor = [FLColor blueColor];
        self.textFont = [FLFont systemFontOfSize:8];
    }
    
    return self;
}

- (NSAttributedString*) buildAttributedString {
    NSMutableAttributedString* outString = FLAutorelease([[NSMutableAttributedString alloc] init]);
    for(FLBreadcrumb* breadcrumb in _breadcrumbs.forwardObjectEnumerator) {
        if(FLStringIsEmpty(breadcrumb.string) || breadcrumb.isHidden) {
            continue;
        }
    
        [outString appendAttributedString:breadcrumb.attributedString];
    }
    
    return outString;
}

- (void) dealloc {
    if(_frameRef) {
        CFRelease(_frameRef);
    }

#if FL_MRC
    [_enabledTextColor release];
    [_disabledTextColor release];
    [_highlightedTextColor release];
    [_textFont release];
    [_breadcrumbs release];
    [super dealloc];
#endif
}

- (FLBreadcrumb*) breadcrumbAtIndex:(NSUInteger) index {
    return [_breadcrumbs objectAtIndex:index];
}

- (FLBreadcrumb*) breadcrumbForIndex:(NSString*) key {
    return [_breadcrumbs objectForKey:key];
}

- (void) setBreadcrumbString:(NSString*) string 
          forBreadcrumbIndex:(NSUInteger) stringIndex {
    [[_breadcrumbs objectAtIndex:stringIndex] setString:string];
    [self setNeedsLayout];
}

- (void) setBreadcrumbString:(NSString*) string 
            forBreadcrumbKey:(NSString*) key {
    [[_breadcrumbs objectForKey:key] setString:string];
    [self setNeedsLayout];
}

- (void) setBreadcrumb:(FLBreadcrumb*) breadcrumb 
                forKey:(NSString*) key  {
                
    if(!breadcrumb.enabledTextColor) {
        breadcrumb.enabledTextColor = self.enabledTextColor;
    }
    if(!breadcrumb.disabledTextColor) {
        breadcrumb.disabledTextColor = self.disabledTextColor;
    }
    if(!breadcrumb.highlightedTextColor) {
        breadcrumb.highlightedTextColor = self.highlightedTextColor;
    }
    if(!breadcrumb.textFont) {
        breadcrumb.textFont = self.textFont;
    }

    [_breadcrumbs addOrReplaceObject:breadcrumb forKey:key];
    [self setNeedsLayout];
}

- (void) setStringForAllBreadcrumbs:(NSString*) string {
    for(FLBreadcrumb* breadcrumb in _breadcrumbs.forwardObjectEnumerator) {
        breadcrumb.string = string;
    }
    
    [self setNeedsLayout];
}

- (void) _setStringRunFrames:(CTFrameRef) frameRef 
                      offset:(CGFloat) offset {

    for(FLBreadcrumb* breadcrumb in _breadcrumbs.forwardObjectEnumerator) {
        [breadcrumb resetRunFrames];
    }
   
    CFArrayRef lines = CTFrameGetLines(frameRef);
    CFIndex lineCount = CFArrayGetCount(lines);
    if(lineCount) {
        CGPoint origins[lineCount];
        
        CGPoint* fuckyou = origins;
        
        for(int i = 0; i < lineCount; i++) {
            origins[i].x = 0;
            origins[i].y = 0;
        
        }
        
        CGRect rect;
        
        rect = FLRectCenterRectInRect(self.bounds, rect);
        
        CTFrameGetLineOrigins(frameRef, CFRangeMake(0, 0), fuckyou);

        for(CFIndex lineIndex = 0; lineIndex < lineCount; lineIndex++) {
            CTLineRef line = CFArrayGetValueAtIndex(lines, lineIndex);

            CFArrayRef runs = CTLineGetGlyphRuns(line);
            for(CFIndex j = 0; j < CFArrayGetCount(runs); j++) {
                CTRunRef run = CFArrayGetValueAtIndex(runs, j);
                CGRect runBounds = CGRectZero;

                CGFloat ascent = 0;//height above the baseline
                CGFloat descent = 0;//height below the baseline
                runBounds.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL);
                runBounds.size.height = ascent + descent;

                CGFloat xOffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
                runBounds.origin.x = origins[lineIndex].x /*+ bounds.origin.x*/ + xOffset;
                runBounds.origin.y = origins[lineIndex].y /*+ bounds.origin.y*/;
                runBounds.origin.y -= descent;

#if IOS
                // convert Rectangle back to view coordinates
                CGRect bounds = self.bounds;
                runBounds = CGRectApplyAffineTransform(runBounds, CGAffineTransformMakeScale(1, -1));
                runBounds = FLRectMoveVertically(runBounds, (bounds.size.height - offset));
#endif

                NSDictionary* attributes = bridge_(NSDictionary*, CTRunGetAttributes(run));
                FLBreadcrumb* breadcrumb = [attributes objectForKey:@"com.fishlamp.breadcrumb"];
                if(breadcrumb) {
                    [breadcrumb addRunFrame:runBounds];
                }
            }
         }
    }
}

- (void) setNeedsLayout {
    [super setNeedsLayout];
    
    if(_frameRef) {
        CFRelease(_frameRef);
        _frameRef = nil;
    }
    
    [self setNeedsDisplay];
}

- (void) _layoutFrameInContext:(CGContextRef) context {
    NSAttributedString* attributedStringToDraw = [self buildAttributedString];

    CGRect bounds = self.bounds;

    CTFramesetterRef framesetter = nil;
    CGMutablePathRef path = CGPathCreateMutable();
    if(!path) goto done;
    
    CGPathAddRect(path, NULL, bounds);

    framesetter = CTFramesetterCreateWithAttributedString(bridge_(CFAttributedStringRef, attributedStringToDraw));
    if(!framesetter) goto done;
   
    // Create the frame and draw it into the graphics context
    _frameRef = CTFramesetterCreateFrame(framesetter,
                                          CFRangeMake(0, attributedStringToDraw.length), path, NULL);
    
    if(!_frameRef) goto done;

    CGFloat boxOffset = 0.0f;

    if(_verticalTextAlignment != FLVerticalTextAlignmentTop) {
        CFArrayRef lines = CTFrameGetLines(_frameRef);
        CFIndex lineCount = CFArrayGetCount(lines);
        if(lineCount) {
            CGFloat size = 0;
            
            for(CFIndex lineIndex = 0; lineIndex < lineCount; lineIndex++) {
                CTLineRef line = CFArrayGetValueAtIndex(lines, lineIndex);
                CGRect lineBounds = CTLineGetImageBounds(line, context);
                size += lineBounds.size.height;
            }
         
            size = ceilf(size);
            size += 2.0f;
            
            if(size < bounds.size.height) {
                switch(_verticalTextAlignment) {
                    case FLVerticalTextAlignmentTop:
                    break;
                    
                    case FLVerticalTextAlignmentCenter:
                        boxOffset = -((bounds.size.height / 2.0f) - (size / 2.0f));
                    break;
                    
                    case FLVerticalTextAlignmentBottom:
                        boxOffset = -(bounds.size.height - size);
                    break;
                }
                
                if(boxOffset != 0.0f) {
                    CGContextTranslateCTM(context, 0.0, boxOffset);
                }
            }
        }
    }

    [self _setStringRunFrames:_frameRef offset:boxOffset];

done:
    
    if(path) {
        CFRelease(path);
    } 
    if(framesetter) {
        CFRelease(framesetter);
    }
}

- (void) drawRect:(CGRect) drawRect {
    [super drawRect:drawRect];

    CGContextRef context = FLGraphicsGetCurrentContext();
    CGContextSaveGState(context);

#if IOS
    // flip to context coordinates for drawing text.
    CGRect bounds = self.bounds;
    CGContextTranslateCTM(context, 0.0, bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
#endif

    if(!_frameRef) {    
        [self _layoutFrameInContext:context];
    }
    
    if(_frameRef) {
        CTFrameDraw(_frameRef, context);
    }
     
    CGContextRestoreGState(context);
}

- (FLBreadcrumb*) breadcrumbAtPoint:(CGPoint) point {
    for(FLBreadcrumb* breadcrumb in _breadcrumbs.forwardObjectEnumerator) {
        if([breadcrumb pointInString:point]) {
            return breadcrumb;
        }
    }
    return nil;
}


#if IOS
- (void) _updateTouch:(NSSet *)touches 
    withEvent:(UIEvent *)event 
    isTouching:(BOOL) isTouching {
    UITouch* touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self];
    FLBreadcrumb* touchingstring = [self stringForPoint:pt];

	for(FLBreadcrumb* breadcrumb in _breadcrumbs.forwardObjectEnumerator) {
        if(breadcrumb.isHighlighted != isTouching) {
            if(touchingstring == breadcrumb && breadcrumb.isTouchable) {
                if(breadcrumb.isTouchable) {
                    touchingstring.highlighted = isTouching;
                    FLAssert_v(touchingstring.highlighted == isTouching, @"switch failed");
                    FLLog(@"touched %@", breadcrumb.text);
                }
            }
            else {
                breadcrumb.highlighted = NO;
            }
        }
    }
    
    [self setNeedsLayout];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self _updateTouch:touches withEvent:event isTouching:YES];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self _updateTouch:touches withEvent:event isTouching:YES];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self _updateTouch:touches withEvent:event isTouching:NO];
}

-(void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event  {	
    [self _updateTouch:touches withEvent:event isTouching:NO];
}
#endif


@end

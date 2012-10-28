//
//  FLTouchableStringView.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/29/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLTouchableStringView.h"

@implementation FLTouchableStringView

@synthesize strings = _strings;
@synthesize verticalTextAlignment = _verticalTextAlignment;

- (id) initWithFrame:(FLRect) frame
{
    if((self = [super initWithFrame:frame]))
    {
        self.userInteractionEnabled = YES; 
        self.backgroundColor = [UIColor clearColor];
        
        _strings = [[FLOrderedCollection alloc] init];
    }
    
    return self;
}

- (NSAttributedString*) buildAttributedString
{
    NSMutableAttributedString* outString = FLReturnAutoreleased([[NSMutableAttributedString alloc] init]);
    for(FLTouchableString* string in _strings.forwardObjectEnumerator)
    {
        if(FLStringIsEmpty(string.text) || string.isHidden)
        {
            continue;
        }
    
        [outString appendAttributedString:string.attributedString];
    }
    
    return outString;
}

- (void) dealloc
{
    if(_frameRef)
    {
        CFRelease(_frameRef);
    }

    FLRelease(_strings);
    FLSuperDealloc();
}

- (FLTouchableString*) attributedStringForIndex:(NSUInteger) index
{
    return [_strings objectAtIndex:index];
}

- (FLTouchableString*) attributedStringForKey:(NSString*) key
{
    return [_strings objectForKey:key];
}

- (void) updateString:(NSString*) string atIndex:(NSUInteger) stringIndex
{
    [[_strings objectAtIndex:stringIndex] setText:string];

    [self setNeedsLayout];
}

- (void) updateString:(NSString*) string forKey:(NSString*) key
{
    [[_strings objectForKey:key] setText:string];

    [self setNeedsLayout];
}

- (void) addAttributedString:(FLTouchableString*) string forKey:(NSString*) key 
{
    [_strings addOrReplaceObject:string forKey:key];

    [self setNeedsLayout];
    
}

- (void) clearAllStrings
{
    for(FLTouchableString* string in _strings.forwardObjectEnumerator)
    {
        string.text = @"";
    }
    
    [self setNeedsLayout];
}

- (void) _setStringRunFrames:(CTFrameRef) frameRef offset:(CGFloat) offset
{
    FLRect bounds = self.bounds;

//    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for(FLTouchableString* string in _strings.forwardObjectEnumerator)
    {
        [string resetRunFrames];
    }
   
    CFArrayRef lines = CTFrameGetLines(frameRef);
    CFIndex lineCount = CFArrayGetCount(lines);
    if(lineCount)
    {
        FLPoint origins[lineCount];
        CTFrameGetLineOrigins(frameRef, CFRangeMake(0, 0), origins);

        for(CFIndex lineIndex = 0; lineIndex < lineCount; lineIndex++)
        {
            CTLineRef line = CFArrayGetValueAtIndex(lines, lineIndex);

            CFArrayRef runs = CTLineGetGlyphRuns(line);
            for(CFIndex j = 0; j < CFArrayGetCount(runs); j++)
            {
                CTRunRef run = CFArrayGetValueAtIndex(runs, j);
                FLRect runBounds = CGRectZero;

                CGFloat ascent = 0;//height above the baseline
                CGFloat descent = 0;//height below the baseline
                runBounds.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL);
                runBounds.size.height = ascent + descent;

                CGFloat xOffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
                runBounds.origin.x = origins[lineIndex].x /*+ bounds.origin.x*/ + xOffset;
                runBounds.origin.y = origins[lineIndex].y /*+ bounds.origin.y*/;
                runBounds.origin.y -= descent;

                // convert Rectangle back to view coordinates
                runBounds = CGRectApplyAffineTransform(runBounds, CGAffineTransformMakeScale(1, -1));
                runBounds = FLRectMoveVertically(runBounds, (bounds.size.height - offset));

                NSDictionary* attributes = (__bridge_fl NSDictionary*)CTRunGetAttributes(run);
                FLTouchableString* string = [attributes objectForKey:@"attr_str"];
                if(string)
                {
                    [string addRunFrame:runBounds];
                }
            }
         }
    }
}

- (void) setNeedsLayout
{
    [super setNeedsLayout];
    
    if(_frameRef)
    {
        CFRelease(_frameRef);
        _frameRef = nil;
    }
    
    [self setNeedsDisplay];
}

- (void) _layoutFrameInContext:(CGContextRef) context
{
    NSAttributedString* string = [self buildAttributedString];

    FLRect bounds = self.bounds;

    CTFramesetterRef framesetter = nil;
    CGMutablePathRef path = CGPathCreateMutable();
    if(!path) goto done;
    
    CGPathAddRect(path, NULL, bounds);

    framesetter = CTFramesetterCreateWithAttributedString((__bridge_fl CFAttributedStringRef) string);
    if(!framesetter) goto done;
   
    // Create the frame and draw it into the graphics context
    _frameRef = CTFramesetterCreateFrame(framesetter,
                                          CFRangeMake(0, 0), path, NULL);
    
    if(!_frameRef) goto done;

    CGFloat boxOffset = 0.0f;

    if(_verticalTextAlignment != FLVerticalTextAlignmentTop)
    {
        CFArrayRef lines = CTFrameGetLines(_frameRef);
        CFIndex lineCount = CFArrayGetCount(lines);
        if(lineCount)
        {
            CGFloat size = 0;
            
            for(CFIndex lineIndex = 0; lineIndex < lineCount; lineIndex++)
            {
                CTLineRef line = CFArrayGetValueAtIndex(lines, lineIndex);
                FLRect lineBounds = CTLineGetImageBounds(line, context);
                size += lineBounds.size.height;
            }
         
            size = ceilf(size);
            size += 2.0f;
            
            if(size < bounds.size.height)
            {
                switch(_verticalTextAlignment)
                {
                    case FLVerticalTextAlignmentTop:
                    break;
                    
                    case FLVerticalTextAlignmentCenter:
                        boxOffset = -((bounds.size.height / 2.0f) - (size / 2.0f));
                    break;
                    
                    case FLVerticalTextAlignmentBottom:
                        boxOffset = -(bounds.size.height - size);
                    break;
                }
                
                if(boxOffset != 0.0f)
                {
                    CGContextTranslateCTM(context, 0.0, boxOffset);
                }
            }
        }
    }

    [self _setStringRunFrames:_frameRef offset:boxOffset];

done:
    
    if(path)
    {
        CFRelease(path);
    } 
    if(framesetter)
    {
        CFRelease(framesetter);
    }
}

- (void) drawRect:(FLRect) drawRect
{
    [super drawRect:drawRect];
    
    FLRect bounds = self.bounds;

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);

    // flip to context coordinates for drawing text.
    CGContextTranslateCTM(context, 0.0, bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);

    if(!_frameRef)
    {    
        [self _layoutFrameInContext:context];
    }
    
    if(_frameRef)
    {
        CTFrameDraw(_frameRef, context);
    }
     
    CGContextRestoreGState(context);
}

- (FLTouchableString*) stringForPoint:(FLPoint) point
{
    for(FLTouchableString* string in _strings.forwardObjectEnumerator)
    {
        if([string pointInString:point])
        {
            return string;
        }
    }
    return nil;
}


- (void) _updateTouch:(NSSet *)touches 
    withEvent:(UIEvent *)event 
    isTouching:(BOOL) isTouching
{
    UITouch* touch = [touches anyObject];
    FLPoint pt = [touch locationInView:self];
    FLTouchableString* touchingstring = [self stringForPoint:pt];

	for(FLTouchableString* string in _strings.forwardObjectEnumerator)
    {
        if(string.isHighlighted != isTouching)
        {
            if(touchingstring == string && string.isTouchable)
            {
                if(string.isTouchable)
                {
                    touchingstring.highlighted = isTouching;
                    FLAssert_v(touchingstring.highlighted == isTouching, @"switch failed");
                    FLLog(@"touched %@", string.text);
                }
            }
            else
            {
                string.highlighted = NO;
            }
        }
    }
    
    [self setNeedsLayout];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self _updateTouch:touches withEvent:event isTouching:YES];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self _updateTouch:touches withEvent:event isTouching:YES];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self _updateTouch:touches withEvent:event isTouching:NO];
}

-(void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event 
{	
    [self _updateTouch:touches withEvent:event isTouching:NO];
}



@end

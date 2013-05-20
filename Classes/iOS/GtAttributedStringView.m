//
//  GtAttributedStringView.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/29/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtAttributedStringView.h"

@implementation GtAttributedStringView

@synthesize strings = m_strings;
@synthesize verticalTextAlignment = m_verticalTextAlignment;

- (id) initWithFrame:(CGRect) frame
{
    if((self = [super initWithFrame:frame]))
    {
        self.userInteractionEnabled = YES; 
        self.backgroundColor = [UIColor clearColor];
        
        m_strings = [[GtOrderedCollection alloc] init];
    }
    
    return self;
}

- (NSAttributedString*) buildAttributedString
{
    NSMutableAttributedString* outString = GtReturnAutoreleased([[NSMutableAttributedString alloc] init]);
    for(GtAttributedString* string in m_strings.forwardObjectEnumerator)
    {
        if(GtStringIsEmpty(string.text) || string.isHidden)
        {
            continue;
        }
    
        [outString appendAttributedString:string.attributedString];
    }
    
    return outString;
}

- (void) dealloc
{
    if(m_frameRef)
    {
        CFRelease(m_frameRef);
    }

    GtRelease(m_strings);
    GtSuperDealloc();
}

- (GtAttributedString*) attributedStringForIndex:(NSUInteger) index
{
    return [m_strings objectAtIndex:index];
}

- (GtAttributedString*) attributedStringForKey:(NSString*) key
{
    return [m_strings objectForKey:key];
}

- (void) updateString:(NSString*) string atIndex:(NSUInteger) stringIndex
{
    [[m_strings objectAtIndex:stringIndex] setText:string];

    [self setNeedsLayout];
}

- (void) updateString:(NSString*) string forKey:(NSString*) key
{
    [[m_strings objectForKey:key] setText:string];

    [self setNeedsLayout];
}

- (void) addAttributedString:(GtAttributedString*) string forKey:(NSString*) key 
{
    [m_strings addOrReplaceObject:string forKey:key];

    [self setNeedsLayout];
    
}

- (void) clearAllStrings
{
    for(GtAttributedString* string in m_strings.forwardObjectEnumerator)
    {
        string.text = @"";
    }
    
    [self setNeedsLayout];
}

- (void) _setStringRunFrames:(CTFrameRef) frameRef offset:(CGFloat) offset
{
    CGRect bounds = self.bounds;

//    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for(GtAttributedString* string in m_strings.forwardObjectEnumerator)
    {
        [string resetRunFrames];
    }
   
    CFArrayRef lines = CTFrameGetLines(frameRef);
    CFIndex lineCount = CFArrayGetCount(lines);
    if(lineCount)
    {
        CGPoint origins[lineCount];
        CTFrameGetLineOrigins(frameRef, CFRangeMake(0, 0), origins);

        for(CFIndex lineIndex = 0; lineIndex < lineCount; lineIndex++)
        {
            CTLineRef line = CFArrayGetValueAtIndex(lines, lineIndex);

            CFArrayRef runs = CTLineGetGlyphRuns(line);
            for(CFIndex j = 0; j < CFArrayGetCount(runs); j++)
            {
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

                // convert Rectangle back to view coordinates
                runBounds = CGRectApplyAffineTransform(runBounds, CGAffineTransformMakeScale(1, -1));
                runBounds = GtRectMoveVertically(runBounds, (bounds.size.height - offset));

                NSDictionary* attributes = (NSDictionary*)CTRunGetAttributes(run);
                GtAttributedString* string = [attributes objectForKey:@"attr_str"];
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
    
    if(m_frameRef)
    {
        CFRelease(m_frameRef);
        m_frameRef = nil;
    }
    
    [self setNeedsDisplay];
}

- (void) _layoutFrameInContext:(CGContextRef) context
{
    NSAttributedString* string = [self buildAttributedString];
    CTFramesetterRef framesetter = nil;
    
    CGRect bounds = self.bounds;

    CGMutablePathRef path = CGPathCreateMutable();
    if(!path) goto done;
    
    CGPathAddRect(path, NULL, bounds);

    framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef) string);
    if(!framesetter) goto done;
   
    // Create the frame and draw it into the graphics context
    m_frameRef = CTFramesetterCreateFrame(framesetter,
                                          CFRangeMake(0, 0), path, NULL);
    
    if(!m_frameRef) goto done;

    CGFloat boxOffset = 0.0f;

    if(m_verticalTextAlignment != GtVerticalTextAlignmentTop)
    {
        CFArrayRef lines = CTFrameGetLines(m_frameRef);
        CFIndex lineCount = CFArrayGetCount(lines);
        if(lineCount)
        {
            CGFloat size = 0;
            
            for(CFIndex lineIndex = 0; lineIndex < lineCount; lineIndex++)
            {
                CTLineRef line = CFArrayGetValueAtIndex(lines, lineIndex);
                CGRect lineBounds = CTLineGetImageBounds(line, context);
                size += lineBounds.size.height;
            }
         
            size = ceilf(size);
            size += 2.0f;
            
            if(size < bounds.size.height)
            {
                switch(m_verticalTextAlignment)
                {
                    case GtVerticalTextAlignmentTop:
                    break;
                    
                    case GtVerticalTextAlignmentCenter:
                        boxOffset = -((bounds.size.height / 2.0f) - (size / 2.0f));
                    break;
                    
                    case GtVerticalTextAlignmentBottom:
                        boxOffset = -(bounds.size.height - size);
                    break;
                }
                
                if(boxOffset != 0)
                {
                    CGContextTranslateCTM(context, 0.0, boxOffset);
                }
            }
        }
    }

    [self _setStringRunFrames:m_frameRef offset:boxOffset];

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

- (void) drawRect:(CGRect) drawRect
{
    [super drawRect:drawRect];
    
    CGRect bounds = self.bounds;

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);

    // flip to context coordinates for drawing text.
    CGContextTranslateCTM(context, 0.0, bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);

    if(!m_frameRef)
    {    
        [self _layoutFrameInContext:context];
    }
    
    if(m_frameRef)
    {
        CTFrameDraw(m_frameRef, context);
    }
     
    CGContextRestoreGState(context);
}

- (GtAttributedString*) stringForPoint:(CGPoint) point
{
    for(GtAttributedString* string in m_strings.forwardObjectEnumerator)
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
    CGPoint pt = [touch locationInView:self];
    GtAttributedString* touchingstring = [self stringForPoint:pt];

	for(GtAttributedString* string in m_strings.forwardObjectEnumerator)
    {
        if(string.isHighlighted != isTouching)
        {
            if(touchingstring == string && string.isTouchable)
            {
                if(string.isTouchable)
                {
                    touchingstring.highlighted = isTouching;
                    GtAssert(touchingstring.highlighted == isTouching, @"switch failed");
                    GtLog(@"touched %@", string.text);
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

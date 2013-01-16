//
//  FLCoreText.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/3/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCoreText.h"

@implementation FLCoreText 

+ (CGSize) lineSize:(CTLineRef) line {
	CGFloat ascent = 0;
    CGFloat descent = 0; 
    CGFloat leading = 0;
    
	CGFloat width = CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
	CGFloat height = ascent + descent + leading;
	
    return CGSizeMake(ceil(width), ceil(height));
}

// see http://lists.apple.com/archives/quartz-dev/2008/Mar/msg00079.html

+ (CGFloat) frameWidth:(CTFrameRef) frameRef {
    CFArrayRef lines = CTFrameGetLines(frameRef);
    CFIndex lineCount = CFArrayGetCount(lines);
    if(lineCount == 0) {
        return 0;
    }

    CGFloat width = 0;
    for(int i = 0; i < lineCount; i++) {
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        CGSize size = [self lineSize:line];
        width = MAX(size.width, width);
    }
    
    return ceil(width); 
}
	
+ (CGFloat) frameHeight:(CTFrameRef) frameRef {
    
    CFArrayRef lines = CTFrameGetLines(frameRef);
    CFIndex lineCount = CFArrayGetCount(lines);
    if(lineCount == 0) {
        return 0;
    }

    CGFloat ascent = 0;
    CGFloat descent = 0; 
    CGFloat leading = 0;
    CTLineGetTypographicBounds(CFArrayGetValueAtIndex(lines, lineCount - 1), &ascent, &descent, &leading);

    CGPoint lastLineOrigin = { 0, 0 };
    CTFrameGetLineOrigins(frameRef, CFRangeMake(lineCount - 1, 0), &lastLineOrigin);
    CGRect frameRect = CGPathGetBoundingBox(CTFrameGetPath(frameRef));

    // The height needed to draw the text is from the bottom of the last line
    // to the top of the frame.
    return ceil(CGRectGetMaxY(frameRect) - lastLineOrigin.y + descent);
}

+ (CGSize) frameSize:(CTFrameRef) frameRef {
    return CGSizeMake([self frameWidth:frameRef], [self frameHeight:frameRef]);
}

+ (CTFrameRef) frameForString:(NSAttributedString*) string
                      inBounds:(CGRect) bounds {
       
    CTFramesetterRef framesetter = nil;
    CGMutablePathRef path = CGPathCreateMutable();
    if(!path) {
        return nil;
    }

    @try {
    
        CGPathAddRect(path, NULL, bounds);

        framesetter = CTFramesetterCreateWithAttributedString(bridge_(CFAttributedStringRef, string));
        if(!framesetter) {
            return nil;
        }

        return CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    }
    @finally {
        if(path) {
            CFRelease(path);
        } 
        if(framesetter) {
            CFRelease(framesetter);
        }
    }

    return nil;
}

+ (CGPoint) offsetForTextAlignment:(FLTextAlignment) textAlignment 
                         withFrame:(CTFrameRef) frameRef 
                          inBounds:(CGRect) bounds {

    CGSize size = [self frameSize:frameRef];
    
    size.height += 2.0f;
            
    CGPoint offset = { 0, 0 };        
    if(size.height < bounds.size.height) {
        switch(textAlignment.vertical) {
            case FLVerticalTextAlignmentTop:
            break;
            
            case FLVerticalTextAlignmentCenter:
                offset.y = -((bounds.size.height / 2.0f) - (size.height / 2.0f));
            break;
            
            case FLVerticalTextAlignmentBottom:
                offset.y = -(bounds.size.height - size.height);
            break;
        }
    }
    
    
    if(size.width < bounds.size.width) {
        switch(textAlignment.horizontal) {
            case FLHorizontalTextAlignmentLeft:
                
            break;

            case FLHorizontalTextAlignmentCenter:
                offset.x = FLRectGetCenter(bounds).x - (size.width / 2.0f);
            break;

            case FLHorizontalTextAlignmentRight:
                offset.x = FLRectGetRight(bounds) - size.width;
            break;
        }
    }
    
    // TODO: horizontal.
    
    return offset;
}

+ (void) drawString:(NSAttributedString*) string 
 withTextAlignment:(FLTextAlignment) textAlignment 
          inBounds:(CGRect) bounds {

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);

#if OSX
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
#endif

#if IOS
    // flip to context coordinates for drawing text.
    CGRect bounds = self.bounds;
    CGContextTranslateCTM(context, 0.0, bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
#endif

    CTFrameRef frameRef = [self frameForString:string inBounds:bounds];
          
    CGPoint offset = [self offsetForTextAlignment:textAlignment withFrame:frameRef inBounds:bounds];      
    
    // dunno why you can't just move the frame?? 
    if(offset.y != 0.0 || offset.x != 0.0) {
        CGContextTranslateCTM(context, offset.x, offset.y);
    }          
          
    @try {
        if(frameRef) {
            CTFrameDraw(frameRef, context);
        }
    }
    @finally {
        if(frameRef) {
            CFRelease(frameRef);
        }
        
        CGContextRestoreGState(context);
    }
}

- (CGSize) runSize:(CTRunRef) run {
    CGFloat ascent = 0;//height above the baseline
    CGFloat descent = 0;//height below the baseline
    
    CGSize size;
    size.width = ceil(CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL));
    size.height = ceil(ascent + descent);
    return size;
}

- (CGRect) runBounds:(CTRunRef) run 
              inLine:(CTLineRef) line 
          lineOrigin:(CGPoint) origin {


    CGFloat ascent = 0;//height above the baseline
    CGFloat descent = 0;//height below the baseline
    
    CGFloat width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL);

    CGRect bounds;
    bounds.origin.x = ceil(origin.x + CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL));
    bounds.origin.y = ceil(origin.y - descent);
    bounds.size.width = ceil(width);
    bounds.size.height = ceil(ascent + descent);
    return bounds;
}

//#define max_buf_size 128
//
//- (FLBatchDictionary*) runFramesForString:(NSAttributedString*) string
//                                withFrame:(CTFrameRef) frameRef 
//                                 inBounds:(CGRect) bounds
//                  withTextAlignmentOffset:(CGPoint) offset {
//
//    CFArrayRef lines = CTFrameGetLines(frameRef);
//    CFIndex lineCount = CFArrayGetCount(lines);
//    if(lineCount) {
//        CGPoint* origins = malloc(sizeof(CGPoint*) * lineCount);
//        
//        CTFrameGetLineOrigins(frameRef, CFRangeMake(0, 0), origins);
//
//        for(CFIndex i = 0; i < lineCount; i++) {
//
//            CTLineRef line = CFArrayGetValueAtIndex(lines, i);
//
//            CFArrayRef runs = CTLineGetGlyphRuns(line);
//            for(CFIndex j = 0; j < CFArrayGetCount(runs); j++) {
//                CTRunRef run = CFArrayGetValueAtIndex(runs, j);
//                CGRect runBounds = [self runBounds:run inLine:line lineOrigin:origins[i]];
//
////                CGFloat ascent = 0;//height above the baseline
////                CGFloat descent = 0;//height below the baseline
////                runBounds.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL);
////                runBounds.size.height = ascent + descent;
////
////                CGFloat xOffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
////                runBounds.origin.x = origins[lineIndex].x /*+ bounds.origin.x*/ + xOffset;
////                runBounds.origin.y = origins[lineIndex].y /*+ bounds.origin.y*/;
////                runBounds.origin.y -= descent;
//
//#if IOS
//                // convert Rectangle back to view coordinates
//                runBounds = CGRectApplyAffineTransform(runBounds, CGAffineTransformMakeScale(1, -1));
//                runBounds = FLRectMoveVertically(runBounds, (bounds.size.height - offset.height));
//#endif
//
//                NSDictionary* attributes = bridge_(NSDictionary*, CTRunGetAttributes(run));
//                FLAttributedString* breadcrumb = [attributes objectForKey:@"com.fishlamp.breadcrumb"];
//                if(breadcrumb) {
//                    [breadcrumb addRunFrame:runBounds];
//                }
//            }
//         }
//         
//         free(origins);
//    }
//}


@end

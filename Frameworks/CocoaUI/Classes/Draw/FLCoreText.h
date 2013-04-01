//
//  FLCoreText.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/3/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCocoaUIRequired.h"

#import <CoreText/CoreText.h>
#import "FLCompatibility.h"

extern CGSize CTLineGetSize(CTLineRef line);
extern CGSize CTFrameGetSize(CTFrameRef frameRef);
extern CGSize CTRunGetSize(CTRunRef run);
extern CGRect CTRunGetRect(CTRunRef run, CTLineRef line, CGPoint origin);


// attributed string drawing
extern CTFrameRef CTAttributedStringGetFrame(NSAttributedString* string, CGRect inBounds);
extern CGSize CTAttributedStringGetSize(NSAttributedString* string, CGRect inBounds);
extern void CGContextDrawAttributedString(CGContextRef context, NSAttributedString* string, NSRect rect);

@interface NSAttributedString (FLCoreText)
- (CGSize) sizeForDrawingInBounds:(CGRect) bounds;
- (void) drawInRectWithCoreText:(CGRect) rect;
@end


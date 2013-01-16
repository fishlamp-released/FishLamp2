//
//  FLCoreText.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/3/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCocoaUIRequired.h"

typedef enum { 
    FLVerticalTextAlignmentTop,
    FLVerticalTextAlignmentCenter,
    FLVerticalTextAlignmentBottom
} FLVerticalTextAlignment; 

typedef enum { 
    FLHorizontalTextAlignmentLeft,
    FLHorizontalTextAlignmentCenter,
    FLHorizontalTextAlignmentRight
} FLHorizontalTextAlignment; 

typedef struct {
    FLVerticalTextAlignment vertical;
    FLHorizontalTextAlignment horizontal;
} FLTextAlignment;

@interface FLCoreText : NSObject

+ (CGSize) lineSize:(CTLineRef) line;

+ (CGFloat) frameHeight:(CTFrameRef) frameRef;

+ (CGFloat) frameWidth:(CTFrameRef) frameRef;

+ (CGSize) frameSize:(CTFrameRef) frameRef;

+ (CTFrameRef) frameForString:(NSAttributedString*) string
                     inBounds:(CGRect) bounds;
                      
+ (CGPoint) offsetForTextAlignment:(FLTextAlignment) textAlignment 
                         withFrame:(CTFrameRef) frame 
                          inBounds:(CGRect) bounds;

- (CGRect) runBounds:(CTRunRef) run 
              inLine:(CTLineRef) line 
          lineOrigin:(CGPoint) origin;

- (CGSize) runSize:(CTRunRef) run;

+ (void) drawString:(NSAttributedString*) string 
  withTextAlignment:(FLTextAlignment) textAlignment 
           inBounds:(CGRect) bounds;
          
@end

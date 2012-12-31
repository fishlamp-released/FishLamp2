//
//  FLDrawable.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 12/28/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaUIRequired.h"

typedef void (^FLDrawingBlock)();

@interface FLDrawable : NSObject {
@private
    CGRect _frame;
    CGRect _superBounds;
    
    FLDrawingBlock _finishDrawingBlock;
}

@property (readonly, assign, nonatomic) CGRect frame;
@property (readonly, assign, nonatomic) CGRect superBounds;
@property (readwrite, assign, nonatomic) FLDrawingBlock finishDrawingBlock;

- (void) drawRect:(CGRect) drawRect
            frame:(CGRect) frame
      superBounds:(CGRect) superBounds;
          
- (void) drawRect:(CGRect) drawRect
            frame:(CGRect) frame
      superBounds:(CGRect) superBounds
     drawEnclosed:(FLDrawingBlock) drawBlock;          

// override point.
- (void) drawRect:(CGRect) drawRect;
      
@end

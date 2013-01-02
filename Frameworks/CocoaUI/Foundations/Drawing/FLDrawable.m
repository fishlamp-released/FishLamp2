//
//  FLDrawable.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 12/28/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLDrawable.h"

@implementation FLDrawable

@synthesize frame = _frame;
@synthesize superBounds = _superBounds;
@synthesize finishDrawingBlock = _finishDrawingBlock;

- (void) drawRect:(CGRect) drawRect
                frame:(CGRect) frame
          superBounds:(CGRect) superBounds {
    [self drawRect:drawRect frame:frame superBounds:superBounds drawEnclosed:nil];
}

- (void) drawRect:(CGRect) drawRect
            frame:(CGRect) frame
      superBounds:(CGRect) superBounds
     drawEnclosed:(FLDrawingBlock) drawBlock {

    _frame = frame;
    _superBounds = superBounds;

    [self drawRect:drawRect];      

    if(drawBlock) {
        drawBlock(self); 
    }

    if(_finishDrawingBlock) {
        _finishDrawingBlock(self);
    }

    _finishDrawingBlock = nil;
    _frame = CGRectZero;
    _superBounds = CGRectZero;
}         

- (void) drawRect:(CGRect) drawRect {
}


@end

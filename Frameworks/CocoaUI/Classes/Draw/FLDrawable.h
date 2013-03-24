//
//  FLDrawable.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 12/28/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaUIRequired.h"

@protocol FLDrawableParent <NSObject>
@property (readonly, assign, nonatomic) CGRect bounds;
@property (readonly, assign, nonatomic) SDKView* view;
@end

@protocol FLDrawable <NSObject>

- (void) drawRect:(CGRect) drawRect 
        withFrame:(CGRect) frame 
         inParent:(id) parent
drawEnclosedBlock:(void (^)(void)) drawEnclosedBlock;

@end

//extern void FLDrawRectWithDrawable(id drawable, CGRect drawRect, CGRect frame, id parent, dispatch_block_t drawEnclosed);

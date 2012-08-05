//
//  FLToolbarItemView.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/6/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLToolbarItemView.h"

@implementation FLToolbarItemView

+ (id) toolbarItemView:(UIView*) view 
         onChosenBlock:(FLToolbarViewBlock) onChosenBlock {
    return FLReturnAutoreleased([[[self class] alloc] initWithView:view onChosenBlock:onChosenBlock]);
}

- (void) wasAddedToToolbarView:(FLToolbarView*) view {
    [super wasAddedToToolbarView:view];
    [view addSubview:self.view];
}

- (void) wasRemovedFromToolbarView:(FLToolbarView*) view {
    [self.view removeFromSuperview];
    [super wasAddedToToolbarView:view];
}

@end
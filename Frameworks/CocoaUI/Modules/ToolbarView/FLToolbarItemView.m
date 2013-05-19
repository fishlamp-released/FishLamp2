//
//  FLToolbarItemView.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/6/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLToolbarItemView.h"
#import "FLToolbarView.h"

@implementation FLToolbarItemView

+ (id) toolbarItemView:(SDKView*) view 
         onChosenBlock:(FLToolbarViewBlock) onChosenBlock {
    return FLAutorelease([[[self class] alloc] initWithView:view onChosenBlock:onChosenBlock]);
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
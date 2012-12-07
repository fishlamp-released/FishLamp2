//
//  NSView+FLAdditions.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "NSView+FLAdditions.h"

@implementation NSView (FLAdditions)

- (void)sendToBack {
    id superView = [self superview]; 
    if (superView) {
        FLAutoreleaseObject(FLRetain(self));
        [self removeFromSuperview];
        [superView addSubview:self positioned:NSWindowBelow relativeTo:nil];
    }
}

- (void) addBackgroundView:(NSView*) view {
    view.frame = self.bounds;
    [self addSubview:view positioned:NSWindowBelow relativeTo:nil];
}

@end

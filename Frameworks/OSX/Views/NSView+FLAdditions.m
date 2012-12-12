//
//  NSView+FLAdditions.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "NSView+FLAdditions.h"

@implementation NSView (FLAdditions)

- (void) addBackgroundView:(NSView*) view {
    view.frame = self.bounds;
    [self addSubview:view positioned:NSWindowBelow relativeTo:nil];
}

@end

//
//  FLProgressFactory+iOS.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/21/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLProgressFactory+iOS.h"

#import "FLProgressViewController.h"
#import "FLSimpleProgressView.h"

@implementation FLProgressFactory (iOS)

- (id) simpleProgress {
    return [FLProgressViewController progressViewController:[FLSimpleProgressView class]];
}

@end

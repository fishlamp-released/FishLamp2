//
//  FLProgressFactory+iOS.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/21/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLProgressFactory+iOS.h"

#import "FLProgressViewController.h"
#import "FLSimpleProgressView.h"

@implementation FLProgressFactory (iOS)

- (id) simpleProgress {
    return [FLProgressViewController progressViewController:[FLSimpleProgressView class]];
}

@end

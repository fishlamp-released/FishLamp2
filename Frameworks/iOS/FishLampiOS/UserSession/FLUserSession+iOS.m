//
//  FLUserSession+iOS.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/21/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLUserSession+iOS.h"

#import "FLProgressViewController.h"
#import "FLSimpleProgressView.h"
#import "FLModalPresentationBehavior.h"
#import "FLFullScreenProgressView.h"
#import "FLLengthyTaskProgressViewController.h"

@implementation FLUserSession (iOS)

+ (id) createVersionUpgradeProgressViewController:(FLLengthyTask*) lengthyTask {
    return [FLLengthyTaskProgressViewController lengthyTaskProgressViewController:lengthyTask progressViewClass:[FLFullScreenProgressView class]];
}


+ (id) createUserLoggingOutProgressViewController {
    return [FLProgressViewController progressViewController:[FLSimpleProgressView class] presentationBehavior:[FLModalPresentationBehavior instance]];

}

@end

//
// UIKitModule.m
// FishLamp
//
// Module: UIKitModule
// Module Meta Data: file://UIKitModule.json
// Note: This is a generated file. Modifications will be overwritten.
//
// Created by Mike Fullerton on Thu Dec 13 13:14:00 HST 2012
// Copyright (c) 2012 GreenTongue Software LLC. All Rights Reserved.
//

#if OSX
#import "FishLampCore.h"
#import "UIKit+OSX.h"

@interface FOO : NSObject
@end

@interface UIKitModule : NSObject<FLFrameworkModule>
@end


@implementation UIKitModule
+ (void) initializeModule {
    [UIViewController initUIKitCompatibility];
}
@end

#endif

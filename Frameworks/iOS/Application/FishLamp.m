//
//  UIApplicationDelegate+AllModules.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/12/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCore.h"
#import "FLThemeModule.h"
#import "FLNetworkModuleiOS.h"
#import "FLAssetsLibraryModule.h"
#import "FLBackgroundTaskModuleCore.h"
//#import "FLUserSessionModule.h"
#import "FLApplicationModule.h"
#import "FishLamp.h"

@implementation FishLamp

+ (void) initializeAllModules {
    [FLBackgroundTaskModuleCore initializeModule];
    [FLNetworkModuleiOS initializeModule];
    [FLAssetsLibraryModule initializeModule];
    [FLThemeModule initializeModule];
//    [FLUserSessionModule initializeModule];
    [FLApplicationModule initializeModule];
}

@end

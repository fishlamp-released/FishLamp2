//
//  FLUserSessionModule.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/12/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLUserSessionModule.h"
#import "FLApplicationDataModel.h"
#import "FLUserSession.h"
#import "FLBackgroundTaskModuleCore.h"

@implementation FLUserSessionModule

- (void) initializeModule {
    [FLBackgroundTaskModuleCore initializeModule];
    [[FLUserSession instance] registerForEvents];
}

@end

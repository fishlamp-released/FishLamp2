//
//  FLUserSession+iOS.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/21/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLPhotoUserSession.h"

@interface FLPhotoUserSession (iOS)

+ (id) createVersionUpgradeProgressViewController:(FLLengthyTask*) lengthyTask;
+ (id) createUserLoggingOutProgressViewController;

@end

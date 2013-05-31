//
//  FLUserSession+iOS.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/21/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLPhotoUserSession.h"

@interface FLPhotoUserSession (iOS)

+ (id) createVersionUpgradeProgressViewController:(FLLengthyTask*) lengthyTask;
+ (id) createUserLoggingOutProgressViewController;

@end

//
//  FLAlertViewStyle.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/21/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <UIKit/UIKit.h>

#import "FLThemeApplicator.h"

@interface FLDefaultAlertViewThemeApplicator : NSObject<FLThemeApplicator>

+ (FLDefaultAlertViewThemeApplicator*) alertViewThemeApplicator;

@end

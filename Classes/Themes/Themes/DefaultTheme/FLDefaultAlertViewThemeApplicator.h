//
//  FLAlertViewStyle.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/21/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FLThemeApplicator.h"

@interface FLDefaultAlertViewThemeApplicator : NSObject<FLThemeApplicator>

+ (FLDefaultAlertViewThemeApplicator*) alertViewThemeApplicator;

@end

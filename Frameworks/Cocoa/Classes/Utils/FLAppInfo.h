//
//  FLAppInfo.h
//  FishLamp
//
//  Created by Mike Fullerton on 11/28/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "NSBundle+FLCurrentBundle.h"

@interface FLAppInfo : NSObject 

+ (NSString*) appMarketingVersion;

+ (NSString*) appVersion;       

+ (NSString*) appName;

+ (NSString*) bundleIdentifier;

+ (NSDictionary*) infoDictionary;

@end


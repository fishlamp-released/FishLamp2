//
//  FLAppInfo.h
//  FishLamp
//
//  Created by Mike Fullerton on 11/28/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "NSBundle+FLCurrentBundle.h"

#define FLAppBundleInfoVersionKey       @"CFBundleVersion"
#define FLAppBundleInfoShortVersionKey  @"CFBundleShortVersionString"
#define FLAppBundleInfoAppNameKey       @"CFBundleName"
#define FLAppBundleInfoIdentifierKey    @"CFBundleIdentifier"

@interface FLAppInfo : NSObject 
+ (NSString*) appMarketingVersion;
+ (NSString*) appVersion;       
+ (NSString*) appName;
+ (NSString*) bundleIdentifier;

+ (NSDictionary*) infoDictionary;
+ (void) setInfoDictionary:(NSDictionary*) dictionary; 

+ (void) setAppInfo:(NSString*) bundleIdentifier
            appName:(NSString*) appName
            version:(NSString*) version;

@end

NS_INLINE
NSString* FLUserDefaultPathForKey(NSString* key) {
    return [[FLAppInfo bundleIdentifier] stringByAppendingFormat:@".%@", key];
}
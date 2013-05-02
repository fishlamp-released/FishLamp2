//
//  FLAppInfo.m
//  FishLamp
//
//  Created by Mike Fullerton on 11/28/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLAppInfo.h"

@implementation FLAppInfo

+ (NSBundle*) bundleForInfo {
    NSBundle* bundle = [NSBundle currentBundle];
    if(!bundle) {
        bundle = [NSBundle mainBundle];
    }
    return bundle;
}

+ (NSDictionary*) infoDictionary {
    return [[self bundleForInfo] infoDictionary];
}

+ (id) objectForKey:(id) key {
    return [[self infoDictionary] objectForKey:key];
}

+ (NSString*) appVersion {
    static NSString* s_version = nil; 
	if(!s_version) {
        s_version = [self objectForKey:@"CFBundleVersion"];
        FLAssertNotNil(s_version);
	}

    return s_version;
}

+ (NSString*) appMarketingVersion {
    static NSString* s_version = nil; 
	if(!s_version) {
        s_version = [self objectForKey:@"CFBundleShortVersionString"];
        FLAssertNotNil(s_version);
	}

    return s_version;
}

+ (NSString*) appName {
	static NSString* s_appName = nil;
	if(!s_appName) {
		s_appName = [self objectForKey:@"CFBundleName"];
        FLAssertNotNil(s_appName);
	}

	return s_appName; 
}

+ (NSString*) bundleIdentifier {
	static NSString* s_identifier = nil;
	if(!s_identifier) {
		s_identifier = [self objectForKey:@"CFBundleIdentifier"];
        FLAssertNotNil(s_identifier);
	}

	return s_identifier; 
}



@end

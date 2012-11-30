//
//  FLAppInfo.m
//  Downloader
//
//  Created by Mike Fullerton on 11/28/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLAppInfo.h"

@implementation FLAppInfo

+ (NSString*) appVersion {
    static NSString* s_version = nil; 
	if(!s_version) {
        s_version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
	}

    return s_version;
}

+ (NSString*) appMarketingVersion {
	return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString*) appName {
	static NSString* appName = nil;
	if(!appName) {
		appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
	}

	return appName; 
}

+ (NSString*) bundleIdentifier {
	static NSString* appName = nil;
	if(!appName) {
		appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
	}

	return appName; 
}

+ (NSString*) userAgent {

    return nil;
}

+ (NSDictionary*) infoDictionary {
    return [[NSBundle mainBundle] infoDictionary];
    
    
}

@end

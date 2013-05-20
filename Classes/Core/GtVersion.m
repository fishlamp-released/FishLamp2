//
//  GtVersion.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/9/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtVersion.h"


const GtVersion GtVersionZero =  { 0, 0, 0, 0 };
GtVersion s_osVersion;

GtVersion GtVersionFromString(NSString* versionString) {
	GtVersion version = GtVersionZero;
	
    NSArray* split = [versionString componentsSeparatedByString:@"."];
	
    if(split.count >= 4) {
    	version.build = [[split objectAtIndex:3] intValue];
	}
    
    if(split.count >= 3) {
		version.revision = [[split objectAtIndex:2] intValue];
	}
	
    if(split.count >= 2) {
		version.minor = [[split objectAtIndex:1] intValue];
	}
	
    if(split.count >= 1) {
		version.major = [[split objectAtIndex:0] intValue];
	}
	
    return version;
}

NSString* GtStringFromVersion(GtVersion version) {
	return [NSString stringWithFormat:@"%d.%d.%d.%d", version.major, version.minor, version.revision, version.build];
}

void GtSetOSVersion() {
#if IOS
	s_osVersion = GtVersionFromString([UIDevice currentDevice].systemVersion);
#endif
}

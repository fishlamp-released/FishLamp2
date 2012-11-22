//
//  FLOSVersion.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/11/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLOSVersion.h"

FLVersion FLGetOSVersion() 
{
    static FLVersion s_osVersion = { 0, 0, 0, 0};
    
    if(s_osVersion.major == 0) {
#if IOS
        s_osVersion = FLVersionFromString([UIDevice currentDevice].systemVersion);
#else
    // TODO
#endif
    }

    return s_osVersion;
}
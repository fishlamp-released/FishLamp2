//
//  FLNetworkModuleiOS.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/12/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLNetworkModuleiOS.h"

#import "FLHttpRequest.h"
#import "FLGlobalNetworkActivityIndicator.h"
#import "FLNetworkActivityIndicator.h"
#import "FLNetworkModuleCore.h"
#import "NSFileManager+FLExtras.h"
#import "NSURLRequest+HTTP.h"

@implementation FLNetworkModuleiOS

- (void) initializeModule {
    
    [FLNetworkModuleCore initializeModule];

// wire core networkOperation up to mobile networkActivityIndicator	   
	[FLGlobalNetworkActivityIndicator setInstance: [FLNetworkActivityIndicator instance]];

    NSString* defaultUserAgent = [NSString stringWithFormat:@"%@/%@ (%@; %@; %@; %@;)", 
                [NSFileManager appName], 
                [NSFileManager appVersion],
                [UIDevice currentDevice].model,
                [UIDevice currentDevice].machineName,
                [UIDevice currentDevice].systemName,
                [UIDevice currentDevice].systemVersion];

    [FLHttpRequest setDefaultUserAgent:defaultUserAgent];
    [NSURLRequest setDefaultUserAgent:defaultUserAgent];
}

@end

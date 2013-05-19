//
//  FLHttpRequest+iOS.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 2/12/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLHttpRequest+iOS.h"
#import "FLAppInfo.h"
#import "UIDevice+FLExtras.h"

@implementation FLHttpRequestHeaders (iOS)

+ (void) initialize {
    if(![self defaultUserAgent]) {
        [self setDefaultUserAgent:[FLAppInfo userAgent]];
    }

    if(![self defaultUserAgent]) {
        NSString* defaultUserAgent = [NSString stringWithFormat:@"%@/%@ (%@; %@; %@; %@; %@;)", 
            [FLAppInfo appName], 
            [FLAppInfo appVersion],
            [FLAppInfo bundleIdentifier],

            [UIDevice currentDevice].model,
            [UIDevice currentDevice].machineName,
            [UIDevice currentDevice].systemName,
            [UIDevice currentDevice].systemVersion];
            
        [self setDefaultUserAgent:defaultUserAgent];
//            [NSURLRequest setDefaultUserAgent:defaultUserAgent];
        
    }
}
@end

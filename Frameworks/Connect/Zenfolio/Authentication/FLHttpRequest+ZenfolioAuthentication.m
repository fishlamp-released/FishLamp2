//
//  FLHttpRequest+ZenfolioAuthentication.m
//  FishLampConnect
//
//  Created by Mike Fullerton on 2/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLHttpRequest+ZenfolioAuthentication.h"

@implementation FLHttpRequest (ZenfolioAuthentication)
- (void) setAuthenticationToken:(NSString*) token {
    [self.requestHeaders setValue:token forHTTPHeaderField:@"X-Zenfolio-Token"];
    [self.requestHeaders setValue:self.requestHeaders.userAgentHeader forHTTPHeaderField:@"X-Zenfolio-User-Agent"];
}
@end

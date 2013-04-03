//
//  FLHttpRequest+ZenfolioAuthentication.h
//  FishLampConnect
//
//  Created by Mike Fullerton on 2/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLHttpRequest.h"

@interface FLHttpRequest (ZenfolioAuthentication)
- (void) setAuthenticationToken:(NSString*) token;
@end

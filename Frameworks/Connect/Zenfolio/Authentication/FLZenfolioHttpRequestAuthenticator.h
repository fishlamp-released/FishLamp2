//
//  FLZenfolioHttpRequestAuthenticator.h
//  FishLamp
//
//  Created by Mike Fullerton on 12/23/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLHttpRequestAuthenticator.h"

#define FLZenfolioHttpAuthenticationTimeout ((60 * 60) * 12.0f)

@interface FLZenfolioHttpRequestAuthenticator : FLHttpRequestAuthenticator
@end

@interface FLZenfolioRegisteredUserHttpRequestAuthenticator : FLZenfolioHttpRequestAuthenticator
@end

@interface FLZenfolioGuestUserHttpRequestAuthenticator : FLZenfolioHttpRequestAuthenticator
@end

@interface FLHttpRequest (ZenAuth)
- (void) setAuthenticationToken:(NSString*) token;
@end


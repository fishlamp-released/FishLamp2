//
//  FLZenfolioHttpRequestAuthenticator.h
//  FishLamp
//
//  Created by Mike Fullerton on 12/23/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLHttpRequestAuthenticator.h"
@class FLZenfolioUserContext;

#define FLZenfolioHttpAuthenticationTimeout ((60 * 60) * 12.0f)

@interface FLZenfolioHttpRequestAuthenticator : FLHttpRequestAuthenticator {
@private
    __unsafe_unretained FLZenfolioUserContext* _userContext;
}
@property (readwrite, assign) FLZenfolioUserContext* userContext;

+ (id) httpRequestAuthenticator:(FLZenfolioUserContext*) userContext;

@end

@interface FLZenfolioRegisteredUserHttpRequestAuthenticator : FLZenfolioHttpRequestAuthenticator
@end

@interface FLZenfolioGuestUserHttpRequestAuthenticator : FLZenfolioHttpRequestAuthenticator
@end

@interface FLHttpRequest (ZenAuth)
- (void) setAuthenticationToken:(NSString*) token;
@end


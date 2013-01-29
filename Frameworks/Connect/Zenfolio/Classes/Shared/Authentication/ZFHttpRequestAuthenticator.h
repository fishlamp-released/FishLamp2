//
//  ZFHttpRequestAuthenticator.h
//  ZenLib
//
//  Created by Mike Fullerton on 12/23/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLHttpRequestAuthenticator.h"

#define ZFHttpAuthenticationTimeout ((60 * 60) * 12.0f)

@interface ZFHttpRequestAuthenticator : FLHttpRequestAuthenticator
@end

@interface ZFRegisteredUserHttpRequestAuthenticator : ZFHttpRequestAuthenticator
@end

@interface ZFGuestUserHttpRequestAuthenticator : ZFHttpRequestAuthenticator
@end

@interface FLHttpRequest (ZenAuth)
- (void) setAuthenticationToken:(NSString*) token;
@end


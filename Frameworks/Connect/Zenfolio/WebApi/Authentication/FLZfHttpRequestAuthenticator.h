//
//  FLZfHttpRequestAuthenticator.h
//  FishLamp
//
//  Created by Mike Fullerton on 12/23/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLHttpRequestAuthenticator.h"

#define FLZfHttpAuthenticationTimeout ((60 * 60) * 12.0f)

@interface FLZfHttpRequestAuthenticator : FLHttpRequestAuthenticator
@end

@interface FLZfRegisteredUserHttpRequestAuthenticator : FLZfHttpRequestAuthenticator
@end

@interface FLZfGuestUserHttpRequestAuthenticator : FLZfHttpRequestAuthenticator
@end

@interface FLHttpRequest (ZenAuth)
- (void) setAuthenticationToken:(NSString*) token;
@end


//
//  FLObjectAuthenticator.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/1/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"

@protocol FLObjectAuthenticator <NSObject>
// returns new credentials
- (id) authenticateObject:(id) object withCredentials:(id) credentials;
@end

@protocol FLAuthenticated <NSObject>
- (id<FLObjectAuthenticator>) authenticator;
@end

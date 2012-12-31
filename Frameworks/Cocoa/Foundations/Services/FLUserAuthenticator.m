//
//  FLUserAuthenticator.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/28/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLUserAuthenticator.h"

@implementation FLUserAuthenticator 

@synthesize context = _context;
@synthesize userLogin = _userLogin;

- (id) initWithUserLogin:(FLUserLogin*) userLogin {
    self = [super init];
    if(self) {
        _userLogin = FLRetain(userLogin);
    }
    
    return self;
}

- (id) initWithUserName:(NSString*) userName password:(NSString*) password {

    FLUserLogin* login = [FLUserLogin userLogin];
    login.userName = userName;
    login.password = password;

    return [self initWithUserLogin:login];
}

+ (id) userAuthenticator:(NSString*) userName password:(NSString*) password {
    return FLAutorelease([[[self class] alloc] initWithUserName:userName password:password]);
}

+ (id) userAuthenticator:(FLUserLogin*) userLogin {
    return FLAutorelease([[[self class] alloc] initWithUserLogin:userLogin]);
}

#if FL_MRC
- (void) dealloc {
    [_userLogin release];
    [super dealloc];
}
#endif

- (void) didMoveToContext:(id)context  {
    _context = context;
}

- (FLResult) runSynchronously {
    return nil;
}

- (void) startAsyncWithFinisher:(FLFinisher*) finisher {
    [finisher setFinishedWithResult:[self runSynchronously]];
}

@end
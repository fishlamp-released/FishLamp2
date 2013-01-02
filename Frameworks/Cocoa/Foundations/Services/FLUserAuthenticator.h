//
//  FLUserAuthenticator.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/28/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLContextuallyDispatchable.h"
#import "FLUserLogin.h"

@interface FLUserAuthenticator : NSObject<FLContextuallyDispatchable> {
@private
    FLUserLogin* _userLogin;
    id _context;
}
@property (readonly, strong) id context;
@property (readonly, strong, nonatomic) FLUserLogin* userLogin;

- (id) initWithUserLogin:(FLUserLogin*) userLogin;
- (id) initWithUserName:(NSString*) userName password:(NSString*) password;

+ (id) userAuthenticator:(NSString*) userName password:(NSString*) password;
+ (id) userAuthenticator:(FLUserLogin*) userLogin;

- (FLResult) runSynchronously;

@end
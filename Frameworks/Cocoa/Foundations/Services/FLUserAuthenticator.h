//
//  FLUserAuthenticator.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/28/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLOperation.h"
#import "FLUserLogin.h"

@interface FLUserAuthenticator : FLOperation {
@private
    FLUserLogin* _userLogin;
}

@property (readonly, strong, nonatomic) FLUserLogin* userLogin;

- (id) initWithUserLogin:(FLUserLogin*) userLogin;
- (id) initWithUserName:(NSString*) userName password:(NSString*) password;

+ (id) userAuthenticator:(NSString*) userName password:(NSString*) password;
+ (id) userAuthenticator:(FLUserLogin*) userLogin;

@end
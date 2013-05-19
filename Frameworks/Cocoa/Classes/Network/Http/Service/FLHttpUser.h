//
//  FLHttpUser.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/28/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLUserLogin.h"

@interface FLHttpUser : NSObject<NSCopying> {
@private
    FLUserLogin* _userLogin;
    NSTimeInterval _lastAuthenticationTimestamp;
    NSTimeInterval _timeoutInterval;
}

@property (readonly, strong) NSString* userName;

- (id) initWithUserLogin:(FLUserLogin*) userLogin;
+ (id) httpUser:(FLUserLogin*) userLogin;

@property (readwrite, copy, nonatomic) FLUserLogin* userLogin;

@property (readonly, assign, nonatomic, getter=isLoginAuthenticated) BOOL loginAuthenticated;
- (void) setLoginUnathenticated;

@property (readwrite, assign, nonatomic) NSTimeInterval timeoutInterval;
@property (readonly, assign, nonatomic) NSTimeInterval lastAuthenticationTimestamp;
@property (readonly, assign, nonatomic) BOOL authenticationHasExpired;

- (void) resetAuthenticationTimestamp;
- (void) touchAuthenticationTimestamp;


// TODO: abstract this better.
- (NSString*) cacheFolderPath;
- (NSString*) userFolderPath;
- (NSString*) userDataFolderPath;

@end

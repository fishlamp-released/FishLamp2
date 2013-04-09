//
//  FLHttpUser.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/28/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
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

- (id) initWithCredentials:(FLUserLogin*) userLogin;
+ (id) httpUserWithCredentials:(FLUserLogin*) userLogin;

@property (readwrite, copy, nonatomic) FLUserLogin* credentials;

@property (readonly, assign, nonatomic, getter=isAuthenticated) BOOL authenticated;
- (void) setUnathenticated;

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
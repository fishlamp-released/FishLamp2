//
//	FLUserService.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/13/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//
#import "FishLampCore.h"
#import "FLService.h"

@protocol FLUserLoginServiceDelegate;

@interface FLUserService : FLService {
@private    
    NSString* _userName;
    NSString* _password;
    NSString* _authenticationDomain;
    BOOL _rememberPassword;
    __unsafe_unretained id<FLUserLoginServiceDelegate> _delegate;
}
@property (readwrite, assign, nonatomic) id delegate;

@property (readwrite, strong, nonatomic) NSString* userName;
@property (readwrite, strong, nonatomic) NSString* password;
@property (readwrite, assign, nonatomic) BOOL rememberPassword;
@property (readwrite, strong, nonatomic) NSString* authenticationDomain;

+ (id) userService;

- (void) removeFromUserDefaults;
- (void) loadFromUserDefaults;
- (void) saveToUserDefaults;

@end

@protocol FLUserLoginServiceDelegate <NSObject>
- (void) userServiceDidOpen:(FLUserService*) service;
- (void) userServiceDidClose:(FLUserService*) service;
@end


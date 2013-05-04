//
//  FLCredentialsEditor.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 5/3/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCredentialsEditor.h"
#import "FLAuthenticated.h"

@interface FLCredentialsEditor ()
@property (readwrite, strong, nonatomic) id<FLAuthenticated> authenticated;
@property (readwrite, assign, nonatomic, getter=isEditing) BOOL editing;
@end

@implementation FLCredentialsEditor

@synthesize authenticated = _authenticated;
@synthesize editing = _editing;

#if FL_MRC
- (void) dealloc {
	[_authCredentials release];
    [_authenticated release];
	[super dealloc];
}
#endif

- (id) initWithCredentials:(id<FLCredentials>) creds
                 authenticated:(id<FLAuthenticated>) authenticated {
	self = [super init];
	if(self) {
        self.credentials = creds;
        self.authenticated = authenticated;
    }
	return self;
}                 

+ (id) authCredentialEditor:(id<FLCredentials>) creds 
                 authenticated:(id<FLAuthenticated>) authenticator {
     return FLAutorelease([[[self class] alloc] initWithCredentials:creds 
                                                          authenticated:authenticator]);
}

- (void) openIfNeeded {
    if(!_editing) {
        _editing = YES;
        [self startEditing];
    }
}

- (NSString*) userName {
    FLAssertNotNil(_authCredentials);
    return _authCredentials.userName;
}

- (void) didChange {
    [self startEditing];
    [_authenticated credentialsDidChange:self];
}

- (void) setUserName:(NSString*) userName {
    FLAssertNotNil(_authCredentials);

    if(FLStringsAreNotEqual(_authCredentials.userName, userName)) {
        [self didChange];
        _authCredentials.userName = userName;
    }
}

- (NSString*) password {
    FLAssertNotNil(_authCredentials);
    return _authCredentials.password;
}

- (void) setPassword:(NSString*) password {
    FLAssertNotNil(_authCredentials);
    if(FLStringsAreNotEqual(_authCredentials.password, password)) {
        [self didChange];
        _authCredentials.password = password;
    }
}

- (NSNumber*) rememberPassword {
    FLAssertNotNil(_authCredentials);
    return _authCredentials.rememberPassword;
}

- (void) setRememberPassword:(NSNumber*) boolNumber {
    [self openIfNeeded];
    FLAssertNotNil(_authCredentials);

    if( boolNumber != _authCredentials.rememberPassword && 
        boolNumber.boolValue != _authCredentials.rememberPassword.boolValue) {
        
        [self didChange];
        _authCredentials.rememberPassword = boolNumber;
    }
}

- (void) startEditing {
    if(!_editing) {
        FLAssertNotNil(_authCredentials);
        [_authenticated startEditingCredentials:self];
        _editing = YES;
    }
}

- (void) stopEditing {
    if(_editing) {
        FLAssertNotNil(_authCredentials);
        [_authenticated finishEditingCredentials:self];
        _editing = NO;
    }
}

- (id<FLCredentials>) credentials {
    return FLCopyWithAutorelease(_authCredentials);
}

- (void) setCredentials:(id<FLCredentials>) creds {
    FLSetObjectWithMutableCopy(_authCredentials, creds);
}


@end

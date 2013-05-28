//
//  FLCredentialsEditor.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 5/3/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCredentials.h"

@protocol FLAuthenticated;

@interface FLCredentialsEditor : NSObject {
@private
    id<FLMutableCredentials> _authCredentials;
    id<FLAuthenticated> _authenticated;
    BOOL _editing;
}

- (id) initWithCredentials:(id<FLCredentials>) creds
                 authenticated:(id<FLAuthenticated>) authenticator;

+ (id) authCredentialEditor:(id<FLCredentials>) creds 
              authenticated:(id<FLAuthenticated>) authenticator;

@property (readonly, assign, nonatomic, getter=isEditing) BOOL editing;

@property (readwrite, assign, nonatomic) BOOL rememberPassword;
@property (readwrite, strong, nonatomic) NSString* userName;
@property (readwrite, strong, nonatomic) NSString* password;

// returns a copy.
@property (readwrite, copy, nonatomic) id<FLCredentials> credentials;

- (void) startEditing;
- (void) stopEditing;

@end

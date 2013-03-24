//
//  FLStorableUserLogin.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/10/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLUserLogin.h"

@interface FLStorableUserLogin : FLUserLogin {
@private
    NSString* _authenticationDomain;
    BOOL _rememberPassword;
    BOOL _loaded;
}
@property (readwrite, strong, nonatomic) NSString* authenticationDomain;
@property (readwrite, assign, nonatomic) BOOL rememberPassword;
@property (readonly, assign, nonatomic, getter=isLoaded) BOOL loaded;

- (void) loadFromStorage;
- (void) saveToStorage;
@end

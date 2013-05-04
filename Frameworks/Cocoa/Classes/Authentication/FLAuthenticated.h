//
//  FLAuthenticated.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 5/3/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCredentials.h"
#import "FLCredentialsEditor.h"

@protocol FLAuthenticated <NSObject>
- (FLCredentials*) credentials;

- (FLCredentialsEditor*) credentialEditor;

- (void) startEditingCredentials:(FLCredentialsEditor*) editor;
- (void) credentialsDidChange:(FLCredentialsEditor*) editor;
- (void) finishEditingCredentials:(FLCredentialsEditor*) editor;
@end


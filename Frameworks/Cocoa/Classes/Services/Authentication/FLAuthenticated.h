//
//  FLAuthenticated.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 5/3/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCredentials.h"
#import "FLCredentialEditor.h"

@protocol FLAuthenticated <NSObject>
- (FLCredentials*) credentials;

- (FLCredentialEditor*) credentialEditor;

- (void) startEditingCredentials:(FLCredentialEditor*) editor;
- (void) credentialsDidChange:(FLCredentialEditor*) editor;
- (void) finishEditingCredentials:(FLCredentialEditor*) editor;
@end


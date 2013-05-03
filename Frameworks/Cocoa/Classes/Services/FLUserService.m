//
//	FLUserService.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/13/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLUserService.h"
#import "FLLowMemoryHandler.h"
#import "FLApplicationDataVersion.h"
#import "NSFileManager+FLExtras.h"
#import "NSString+Guid.h"
#import "FLService.h"
#import "FLKeychain.h"
#import "NSUserDefaults+FLAdditions.h"
#import "FLUserDefaultsCredentialStorage.h"

@interface FLUserService ()
@property (readwrite, strong, nonatomic) id<FLCredentials> credentials;
@end

@implementation FLUserService
@synthesize credentials = _authCredentials;
@synthesize credentialStorage = _credentialStorage;

- (id) init {
    self = [super initWithRootNameForDelegateMethods:@"userService"];
    if(self) {
        self.credentialStorage = [FLUserDefaultsCredentialStorage instance];
        self.credentials = [self.credentialStorage readCredentialsForLastUser];
    }
    return self;
}

+ (id) userService {
    return FLAutorelease([[[self class] alloc] init]);
}

#if FL_MRC
- (void) dealloc {
    [_credentialStorage release];
    [_authCredentials release];
    [super dealloc];
}
#endif

- (FLCredentialEditor*) credentialEditor {
    return [FLCredentialEditor authCredentialEditor:self.credentials authenticated:self]; 
}

- (void) startEditingCredentials:(FLCredentialEditor*) editor {
   [self closeService:self];
}

- (void) credentialsDidChange:(FLCredentialEditor*) editor {
    self.credentials = editor.credentials;
    [self.credentialStorage writeCredentials:self.credentials];
}

- (void) finishEditingCredentials:(FLCredentialEditor*) editor {
    self.credentials = editor.credentials;
    [self.credentialStorage writeCredentials:self.credentials];
    [self openService:self];
}

- (BOOL) canAuthenticate {
    return [self.credentials canAuthenticate];
}

- (NSString*) userName {
    return [self.credentials userName];
}

@end




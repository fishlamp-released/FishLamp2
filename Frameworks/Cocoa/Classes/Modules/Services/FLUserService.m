//
//	FLUserService.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/13/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLUserService.h"
#import "FLApplicationDataVersion.h"
#import "NSFileManager+FLExtras.h"
#import "NSString+Guid.h"
#import "FLService.h"
#import "FLKeychain.h"
//#import "NSUserDefaults+FLAdditions.h"
#import "FLUserDefaultsCredentialStorage.h"
#import "FLBroadcaster.h"

@interface FLUserService ()
@property (readwrite, strong, nonatomic) id<FLCredentials> credentials;
@end

@implementation FLUserService
@synthesize credentials = _authCredentials;
@synthesize credentialStorage = _credentialStorage;

- (id) init {
    self = [super init];
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

- (FLCredentialsEditor*) credentialEditor {
    return [FLCredentialsEditor authCredentialEditor:self.credentials authenticated:self]; 
}

- (void) startEditingCredentials:(FLCredentialsEditor*) editor {
   [self closeService:self];
}

- (void) credentialsDidChange:(FLCredentialsEditor*) editor {
    self.credentials = editor.credentials;
    [self.credentialStorage writeCredentials:self.credentials];
}

- (void) finishEditingCredentials:(FLCredentialsEditor*) editor {
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

- (void) didOpenService {
    [self.observers notify:@selector(userServiceDidOpen:) withObject:self];
}

- (void) didCloseService {
    [self.observers notify:@selector(userServiceDidClose:) withObject:self];
}

@end




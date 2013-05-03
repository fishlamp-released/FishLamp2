//
//  FLUserDefaultsCredentialStorage.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 5/3/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCredentialStorage.h"

@interface FLUserDefaultsCredentialStorage : NSObject<FLCredentialStorage>
FLSingletonProperty(FLUserDefaultsCredentialStorage);
@end

@interface FLCredentials (NSUserDefaults)
+ (id) authCredentialsFromUserDefaults;

- (void) writeToUserDefaults;
- (void) writePasswordToKeychain;
@end

@interface FLMutableCredentials (NSUserDefaults)
- (void) readFromUserDefaults;
- (void) readPasswordFromKeychain;
- (void) removePasswordFromKeychain;
@end
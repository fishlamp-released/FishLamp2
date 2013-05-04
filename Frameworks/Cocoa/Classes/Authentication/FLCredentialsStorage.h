//
//  FLCredentialsStorage.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 5/3/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCredentials.h"

@protocol FLCredentialsStorage <NSObject>
- (id<FLCredentials>) readCredentialsForLastUser;
- (void) writeCredentials:(id<FLCredentials>) credentials;
@end

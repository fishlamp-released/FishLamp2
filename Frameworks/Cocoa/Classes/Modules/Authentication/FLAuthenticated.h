//
//  FLAuthenticated.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 5/3/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCredentials.h"
#import "FLCredentialsEditor.h"

@protocol FLAuthenticated <NSObject>
- (FLCredentials*) credentials;

@end


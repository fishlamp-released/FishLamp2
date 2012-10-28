//
//  FLFacebookBeginAuthorizationOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/5/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLHttpOperation.h"

@interface FLFacebookBeginAuthorizationOperation : FLHttpOperation {
}
- (id) initWithPermissions:(NSArray*) permissions;
+ (id) facebookBeginAuthorizationOperation:(NSArray*) permissions;
@end

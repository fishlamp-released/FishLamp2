//
//  GtFacebookBeginAuthorizationOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/5/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtHttpOperation.h"

@interface GtFacebookBeginAuthorizationOperation : GtHttpOperation {
}
- (id) initWithPermissions:(NSArray*) permissions;
+ (id) facebookBeginAuthorizationOperation:(NSArray*) permissions;
@end

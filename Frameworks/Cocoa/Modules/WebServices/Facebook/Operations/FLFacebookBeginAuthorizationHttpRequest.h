//
//  FLFacebookBeginAuthorizationHttpRequest.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/5/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"

#import "FLFacebookHttpRequest.h"

@interface FLFacebookBeginAuthorizationHttpRequest : FLFacebookHttpRequest {
@private
    NSArray* _permissions;
}

@property (readwrite, strong) NSArray* permissions;
@end

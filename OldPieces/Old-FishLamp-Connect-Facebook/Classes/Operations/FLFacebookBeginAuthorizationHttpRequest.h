//
//  FLFacebookBeginAuthorizationHttpRequest.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/5/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaRequired.h"

#import "FLFacebookHttpRequest.h"

@interface FLFacebookBeginAuthorizationHttpRequest : FLFacebookHttpRequest {
@private
    NSArray* _permissions;
}

@property (readwrite, strong) NSArray* permissions;
@end

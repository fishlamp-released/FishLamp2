//
//  FLOAuthAuthorizationHeader.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/19/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"

#import "FLOAuthApp.h"
#import "FLOAuthEnums.h"
#import "FLHttpRequest.h"

@interface FLOAuthAuthorizationHeader : NSObject {
@private
	NSMutableDictionary* _parameters;
}

+ (FLOAuthAuthorizationHeader*) authorizationHeader;

// add/set parameters in any order. They'll be sorted when added to the request
- (void) setParameter:(NSString*) parameter
                value:(NSString*) unencodedURLValue;

@end

@interface FLHttpRequest (OAuth)
- (void) setOAuthAuthorizationHeader:(FLOAuthAuthorizationHeader*) signature
                         consumerKey:(NSString*) consumerKey
                              secret:(NSString*) secret;
@end
//
//  FLTwitterHttpRequest.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/1/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaRequired.h"
#import "FLHttp.h"
#import "FLOAuthAuthorizationHeader.h"

@interface FLTwitterHttpRequest : FLHttpRequest {
@private
    id _inputObject;
    NSURL* _twitterURL;
}

@property (readwrite, strong) NSURL* twitterURL;
@property (readwrite, strong) id inputObject;

- (id) initWithTwitterURL:(NSURL*) url;

// optional override points
- (BOOL) willAddParametersToRequestContent:(FLOAuthAuthorizationHeader*) signature;
	// if adding params your self. call [signature addParameter:propName value:theValue]

@end

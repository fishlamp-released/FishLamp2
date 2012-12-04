//
//  FLTwitterOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/1/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLHttpOperation.h"
#import "FLOAuthAuthorizationHeader.h"

@interface FLTwitterOperation : FLHttpOperation<FLHttpRequestAuthenticator> {
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

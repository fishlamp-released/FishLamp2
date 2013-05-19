//
//  FLFacebookHttpRequest.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/14/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaRequired.h"
#import "FLHttp.h"

@class FLFacebookService;
@class FLFacebookNetworkSession;
@class FLFacebookError;

@interface FLFacebookHttpRequest : FLHttpRequest {
@private
	NSString* _object;
    id _outputObject;
    id _inputObject;
}

@property (readwrite, strong) id inputObject;
@property (readwrite, strong) id outputObject;

@property (readwrite, strong) NSString* object;

// override points
- (void) addParametersToURLString:(NSMutableString*) url;
- (BOOL) willAddParametersToURL;

// UTILS

// based on code from facebook demo app

- (FLFacebookNetworkSession*) sessionFromURLParams:(NSDictionary*) params;

- (NSDictionary*)parseURLParams:(NSString *)query;

- (NSMutableString*) buildURL:(NSString*) authenticationToken
                         user:(NSString*) user
                       object:(NSString*) object
                       params:(NSString*) firstParameter, ...;

- (NSString*) serializeURL:(NSString *)baseUrl
				   params:(NSDictionary *)params
			   httpMethod:(NSString *)httpMethod;

- (NSString*) serializeURL:(NSString *)baseUrl
				   params:(NSDictionary *)params;
                       
- (FLFacebookError*) errorFromURLParams:(NSDictionary*) params;

@end



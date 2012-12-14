//
//  FLFacebookBeginAuthorizationOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/5/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLFacebookBeginAuthorizationOperation.h"
#import "FLFacebookService.h"
#import "NSString+URL.h"

// - (FLFacebookAuthenticationResponse*) parseAuthenticationResponseFromURL:(NSURL*) url

@implementation FLFacebookBeginAuthorizationOperation

@synthesize permissions = _permissions;

#if FL_MRC
- (void) dealloc {
    [_permissions release];
    [super dealloc];
}
#endif
static NSString* kRedirectURL = @"http://www.facebook.com/connect/login_success.html";

#define URL @"https://www.facebook.com/dialog/oauth?"

//     client_id=%@&redirect_uri=%@&scope=email,read_stream&
//     response_type=token

- (NSURL*) buildOAuthUrl:(NSArray *)permissions forAppId:(NSString*) appId
{
	NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								appId, @"client_id",
									@"user_agent", @"type",
                                 kRedirectURL, @"redirect_uri",
                                @"touch", @"display",
								 @"token", @"response_type",
                           //      kSDKVersion, @"sdk",
                                 nil];
	if (permissions != nil) 
	{
		NSString* scope = [permissions componentsJoinedByString:@","];
		[params setValue:scope forKey:@"scope"];
	}
	
	return [NSURL URLWithString:[self serializeURL:URL params:params]];
}

- (FLFacebookAuthenticationResponse*) parseAuthenticationResponseFromURL:(NSURL*) url {
	
    FLFacebookAuthenticationResponse* response = 
		[FLFacebookAuthenticationResponse facebookAuthenticationResponse];

// this code from the demo app.	
	NSString *query = [[url fragment] urlDecodeString:NSUTF8StringEncoding];

	// Version 3.2.3 of the Facebook app encodes the parameters in the query but
	// version 3.3 and above encode the parameters in the fragment. To support
	// both versions of the Facebook app, we try to parse the query if
	// the fragment is missing.
	if (!query) {
		query = [[url query] urlDecodeString:NSUTF8StringEncoding];
	}
	
	NSDictionary *params = [self parseURLParams:query];
	FLFacebookNetworkSession* facebookNetworkSession = [self sessionFromURLParams:params];
	if(facebookNetworkSession) {
		response.session = facebookNetworkSession;
	}
	else {
		FLFacebookError* fberror = [self errorFromURLParams:params];
		if(fberror) {
			FLThrowError([NSError errorWithDomain:FLFacebookErrorDomain 
					code:FLFacebookErrorCodeAuthenticationFailed 
					userInfo:[NSDictionary dictionaryWithObject:fberror forKey:FLFacebookErrorKey]]);
		}
		else {
			response.redirectURL = url;
		}
	}
	
	return response;
}




- (FLResult) runSelf:(id) input {

    [FLFacebookService clearHTTPCookies];

//    NSURL* url = [self buildOAuthUrl:self.permissions
//                            forAppId:[[FLFacebookService serviceFromContext:self.context] appId]];

// FIXME
//    FLFacebookService* facebook = [self.context facebookService];


//    FLMutableHttpRequest* httpRequest = [FLMutableHttpRequest httpRequestWithURL:url];
//
//    FLHttpResponse* httpResponse = [self sendHttpRequest:httpRequest withAuthenticator:nil];

    // i think the auth response is coming back in a redirectURL. weird.


//    NSError* error = nil;
//    result = [self parseAuthenticationResponseFromURL:httpResponse.requestURL];
//    if(error) {
//        FLThrowError_(error);
//    }
//
//    
//    return result;

    return nil;
}

- (void) networkConnection:(FLNetworkConnection*) connection
            shouldRedirect:(BOOL*) redirect
                     toURL:(NSURL*) url {
    *redirect = NO;
}


@end

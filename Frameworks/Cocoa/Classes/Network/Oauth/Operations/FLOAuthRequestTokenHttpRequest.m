//
//  FLOAuthRequestTokenHttpRequest.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/1/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLOAuthRequestTokenHttpRequest.h"
#import "NSString+URL.h"
#import "FLOAuthAuthencationData.h"
#import "FLUrlParameterParser.h"
#import "FLOAuthAuthorizationHeader.h"
#import "FLHttpResponse.h"

@implementation FLOAuthRequestTokenHttpRequest

- (id) initWithOAuthApp:(FLOAuthApp*) app {
    self = [super init];
	if(self)  {
		_url = [[NSURL alloc] initWithString:app.requestTokenUrl];
        _app = FLRetain(app);
	}
	
	return self;
}

+ (FLOAuthRequestTokenHttpRequest*) OAuthRequestTokenNetworkOperation:(FLOAuthApp*) app {
	return FLAutorelease([[FLOAuthRequestTokenHttpRequest alloc] initWithOAuthApp:app]);
}

#if FL_MRC
- (void) dealloc {
    [_url release];
    [_app release];
    [super dealloc];
}
#endif

- (BOOL) shouldRedirectToURL:(NSURL*) url {
    return NO;
}

- (void) willSendHttpRequest {
    [super willSendHttpRequest];
    FLOAuthAuthorizationHeader* oauthHeader = [FLOAuthAuthorizationHeader authorizationHeader];
    [self setOAuthAuthorizationHeader:oauthHeader
                          consumerKey:_app.consumerKey
                               secret:[_app.consumerSecret stringByAppendingString:@"&"]];

}

- (id) resultFromHttpResponse:(FLHttpResponse*) httpResponse {

    NSData* data = [[httpResponse responseData] data];
    
#if DEBUG
    NSString* responseStr = FLAutorelease([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    FLDebugLog(@"FL OAuthRequestToken response: %@", responseStr);
#endif	

    FLOAuthAuthencationData* response = [FLOAuthAuthencationData oAuthAuthencationData];

    [FLUrlParameterParser parseData:data intoObject:response strict:YES 
        requiredKeys:[NSArray arrayWithObjects:@"oauth_token_secret", @"oauth_token", @"oauth_callback_confirmed", nil]];
        
    return response;

}

//- (id) performSynchronously {
//	
//    
//    FLHttpRequest* request = [FLHttpRequest httpPostRequestWithURL:_url];
//    
//    [request setOAuthAuthorizationHeader:oauthHeader
//                             consumerKey:_app.consumerKey
//                                  secret:[_app.consumerSecret stringByAppendingString:@"&"]];
//    
//    NSData* data = [[self runChildSynchronously:request] responseData];
//    
//#if DEBUG
//    NSString* responseStr = FLAutorelease([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
//    FLDebugLog(@"FL OAuthRequestToken response: %@", responseStr);
//#endif	
//
//    FLOAuthAuthencationData* response = [FLOAuthAuthencationData oAuthAuthencationData];
//
//    [FLUrlParameterParser parseData:data intoObject:response strict:YES 
//        requiredKeys:[NSArray arrayWithObjects:@"oauth_token_secret", @"oauth_token", @"oauth_callback_confirmed", nil]];
//        
//    return response;
//}


@end

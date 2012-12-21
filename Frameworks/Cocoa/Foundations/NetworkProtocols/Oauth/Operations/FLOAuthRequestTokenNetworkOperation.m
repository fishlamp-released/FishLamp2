//
//  FLOAuthRequestTokenNetworkOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/1/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLOAuthRequestTokenNetworkOperation.h"
#import "NSString+URL.h"
#import "FLOAuthAuthencationData.h"
#import "FLUrlParameterParser.h"
#import "FLOAuthAuthorizationHeader.h"

@implementation FLOAuthRequestTokenNetworkOperation

- (id) initWithOAuthApp:(FLOAuthApp*) app {
    self = [super init];
	if(self)  {
		_url = [[NSURL alloc] initWithString:app.requestTokenUrl];
        _app = FLRetain(app);
	}
	
	return self;
}

+ (FLOAuthRequestTokenNetworkOperation*) OAuthRequestTokenNetworkOperation:(FLOAuthApp*) app {
	return FLAutorelease([[FLOAuthRequestTokenNetworkOperation alloc] initWithOAuthApp:app]);
}

#if FL_MRC
- (void) dealloc {
    [_url release];
    [_app release];
    [super dealloc];
}
#endif

- (void) httpStream:(FLHttpStream*) httpStream
     shouldRedirect:(BOOL*) redirect
              toURL:(NSURL*) url {
    *redirect = NO;
}

- (FLResult) runOperationWithInput:(id) input {
	
    FLOAuthAuthorizationHeader* oauthHeader = [FLOAuthAuthorizationHeader authorizationHeader];
    
    FLMutableHttpRequest* request = [FLMutableHttpRequest httpPostRequestWithURL:_url];
    
    [request setOAuthAuthorizationHeader:oauthHeader
                             consumerKey:_app.consumerKey
                                  secret:[_app.consumerSecret stringByAppendingString:@"&"]];
    
    NSData* data = [self sendHttpRequest:request].responseData;
    
#if DEBUG
    NSString* responseStr = FLAutorelease([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    FLDebugLog(@"FL OAuthRequestToken response: %@", responseStr);
#endif	

    FLOAuthAuthencationData* response = [FLOAuthAuthencationData oAuthAuthencationData];

    [FLUrlParameterParser parseData:data intoObject:response strict:YES 
        requiredKeys:[NSArray arrayWithObjects:@"oauth_token_secret", @"oauth_token", @"oauth_callback_confirmed", nil]];
        
    return response;
}


@end

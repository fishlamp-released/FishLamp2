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

@synthesize OAuthApp = _app;

- (id) initWithOAuthApp:(FLOAuthApp*) app {
	if((self = [super initWithURL:[NSURL URLWithString:app.requestTokenUrl]]))  {
		_app = retain_(app);
	}
	
	return self;
}

+ (FLOAuthRequestTokenNetworkOperation*) OAuthRequestTokenNetworkOperation:(FLOAuthApp*) app {
	return autorelease_([[FLOAuthRequestTokenNetworkOperation alloc] initWithOAuthApp:app]);
}

- (void) dealloc {
	release_(_app);
	super_dealloc_();
}

- (void) networkConnection:(FLNetworkConnection*) connection
            shouldRedirect:(BOOL*) redirect
                     toURL:(NSURL*) url {
    *redirect = NO;
}

- (void) runSelf {
    [self.httpRequest setHTTPMethodToPost];
	
    FLOAuthAuthorizationHeader* oauthHeader = [FLOAuthAuthorizationHeader authorizationHeader];
    [self.httpRequest setOAuthAuthorizationHeader:oauthHeader
                                      consumerKey:_app.consumerKey
                                           secret:[_app.consumerSecret stringByAppendingString:@"&"]];
    
    [super runSelf];

    if(self.didSucceed) {
        NSData* data = self.httpResponse.responseData;
#if DEBUG
        NSString* responseStr = autorelease_([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        FLDebugLog(@"FL OAuthRequestToken response: %@", responseStr);
#endif	
        FLOAuthAuthencationData* response = [FLOAuthAuthencationData oAuthAuthencationData];
        [FLUrlParameterParser parseData:data intoObject:response strict:YES 
            requiredKeys:[NSArray arrayWithObjects:@"oauth_token_secret", @"oauth_token", @"oauth_callback_confirmed", nil]];
        
        self.operationOutput = response;
    }
}


@end

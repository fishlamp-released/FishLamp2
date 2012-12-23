//
//  FLTwitterOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/1/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLTwitterOperation.h"
#import "FLOAuthAuthorizationHeader.h"
#import "NSString+URL.h"
#import "FLObjectDescriber.h"
#import "FLJsonParser.h"
#import "FLTwitterService.h"

@implementation FLTwitterOperation

@synthesize inputObject = _inputObject;
@synthesize twitterURL = _twitterURL;


#if FL_MRC
- (void) dealloc {
    [_twitterURL release];
    [_inputObject release];
    [super dealloc];
}
#endif

- (id) initWithTwitterURL:(NSURL*) url {
    self = [super init];
    if(self) {
        self.twitterURL = url;
    }
    return self;
}


- (BOOL) willAddParametersToRequestContent:(FLOAuthAuthorizationHeader*) signature
{
	return YES;
}

- (FLResult) authenticateHTTPRequest:(FLHttpRequest*) httpRequest {
	
    FLOAuthAuthorizationHeader* oauthHeader = [FLOAuthAuthorizationHeader authorizationHeader];
	
    id input = self.inputObject;
    
	NSMutableString* content = [NSMutableString string];
	
	if(input && [self willAddParametersToRequestContent:oauthHeader]) {
        int count = 0;
        FLObjectDescriber* describer = [[input class] sharedObjectDescriber];
        for(NSString* propertyName in describer.propertyDescribers)
        {
            id obj = [input valueForKey:propertyName];
            if(obj)
            {
                FLAssert_v([obj isKindOfClass:[NSString class]], @"not a string"); 
                if(FLStringIsNotEmpty(obj))
                {
                    [content appendAndEncodeURLParameter:obj name:propertyName seperator:(count++ == 0 ? @"" : @"&")];
                    if(oauthHeader) {
                        [oauthHeader setParameter:propertyName value:obj];
                    }
                }
            }
        }
	}
	
	[httpRequest.httpBody setFormUrlEncodedContent:content];

    FLTwitterService* twitter = [self.context twitterService];

	if(oauthHeader) {
        [oauthHeader setParameter:kFLOAuthHeaderToken value:twitter.oauthSession.oauth_token];
        
        NSString* secret = [NSString stringWithFormat:@"%@&%@", 
                                twitter.oauthInfo.consumerSecret, 
                                twitter.oauthSession.oauth_token_secret];
        
        [httpRequest setOAuthAuthorizationHeader:oauthHeader
                                                consumerKey:twitter.oauthInfo.consumerKey
                                                     secret:secret];
	}
    
    return httpRequest;
}


- (FLResult) runOperationWithInput:(id) input {

    FLHttpRequest* httpRequest = [FLHttpRequest httpPostRequestWithURL:self.twitterURL];

    FLHttpResponse* httpResponse = [self sendHttpRequest:httpRequest];
    
    // this is a hack. In the case of a successfull tweet, it's returning a object containing
    // a bunch of info. In the case of an error, it's returning an error object (FLTwitterError).
    // TODO: refactor this.
    
    FLJsonParser* parser = [FLJsonParser jsonParser];
    NSDictionary* twitterResponse = [parser parseJsonData:httpResponse.responseData rootObject:nil];
   
    FLThrowError(parser.error);
    
    if([twitterResponse objectForKey:@"error"]) {
        FLThrowError(
            [NSError errorWithDomain:@"FLTwitterErrorDomain" code:1 localizedDescription:[twitterResponse objectForKey:@"error"]]);
    }

    FLThrowError([httpResponse simpleHttpResponseErrorCheck]);
    
    return twitterResponse;
}
	

@end

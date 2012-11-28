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

@implementation FLTwitterOperation

@synthesize inputObject = _inputObject;

#if FL_MRC
- (void) dealloc {
    [_inputObject release];
    [super dealloc];
}
#endif


- (BOOL) willAddParametersToRequestContent:(FLOAuthAuthorizationHeader*) signature
{
	return YES;
}

- (void) configureRequest {

    FLHttpConnection* connection = self.httpConnection;

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
	
	[connection.httpRequest setFormUrlEncodedContent:content];

    FLTwitterMgr* twitter = [self.context twitterService];

	if(oauthHeader) {
        [oauthHeader setParameter:kFLOAuthHeaderToken value:twitter.oauthSession.oauth_token];
        
        NSString* secret = [NSString stringWithFormat:@"%@&%@", 
                                twitter.oauthInfo.consumerSecret, 
                                twitter.oauthSession.oauth_token_secret];
        
        [connection.httpRequest setOAuthAuthorizationHeader:oauthHeader
                                                consumerKey:twitter.oauthInfo.consumerKey
                                                     secret:secret];
	}
}


- (FLResult) runSelf {
    [self configureRequest];
    
    FLHttpResponse* httpResponse = FLRunSelfForResponse(FLHttpResponse);
    
    // this is a hack. In the case of a successfull tweet, it's returning a object containing
    // a bunch of info. In the case of an error, it's returning an error object (FLTwitterError).
    // TODO: refactor this.
    
    FLJsonParser* parser = [FLJsonParser jsonParser];
    NSDictionary* twitterResponse = [parser parseJsonData:httpResponse.responseData rootObject:nil];
   
     FLThrowError(parser.error);
    
    if([twitterResponse objectForKey:@"error"]) {
        FLThrowError_(
            [NSError errorWithDomain:@"FLTwitterErrorDomain" code:1 localizedDescription:[twitterResponse objectForKey:@"error"]]);
    }

    FLThrowError_([self.httpResponse simpleHttpResponseErrorCheck]);
    
    return twitterResponse;
}
	

@end

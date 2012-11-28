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

@synthesize twitterService = _session;

- (void) dealloc
{
	release_(_session);
	super_dealloc_();
}

- (BOOL) willAddParametersToRequestContent:(FLOAuthAuthorizationHeader*) signature
{
	return YES;
}

- (void) configureRequest {

    FLHttpConnection* connection = self.httpConnection;

	FLOAuthAuthorizationHeader* oauthHeader = nil;
	if(_session) {
		oauthHeader = [FLOAuthAuthorizationHeader authorizationHeader];
    }
	
    id input = self.input;
    
	NSMutableString* content = [NSMutableString string];
	
	if(input && [self willAddParametersToRequestContent:oauthHeader])
	{
        int count = 0;
        FLObjectDescriber* describer = [[self.input class] sharedObjectDescriber];
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

	if(oauthHeader) {
        [oauthHeader setParameter:kFLOAuthHeaderToken value:self.twitterService.oauthSession.oauth_token];
        NSString* secret = [NSString stringWithFormat:@"%@&%@", self.twitterService.oauthInfo.consumerSecret, self.twitterService.oauthSession.oauth_token_secret];
        [connection.httpRequest setOAuthAuthorizationHeader:oauthHeader
                                                consumerKey:self.twitterService.oauthInfo.consumerKey
                                                     secret:secret];
	}
}


- (FLResult) runSelf {
    [self configureRequest];
    [super runSelf];
    
    if(!self.error) {
	
        // this is a hack. In the case of a successfull tweet, it's returning a object containing
        // a bunch of info. In the case of an error, it's returning an error object (FLTwitterError).
        // TODO: refactor this.
        
        FLJsonParser* parser = [FLJsonParser jsonParser];
        NSDictionary* object = [parser parseJsonData:self.httpResponse.responseData rootObject:nil];
        NSError* error = parser.error;
        
        if(!error)
        {
            if([object objectForKey:@"error"])
            {
                error = [NSError errorWithDomain:@"FLTwitterErrorDomain" code:1 localizedDescription:[object objectForKey:@"error"]];
            }
        }

        if(!error) {
            error = [self.httpResponse simpleHttpResponseErrorCheck];
        }
        
        self.error = error;
    }
}
	

@end

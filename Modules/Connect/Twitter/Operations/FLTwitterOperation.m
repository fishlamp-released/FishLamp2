//
//  FLTwitterOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/1/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLTwitterOperation.h"
#import "FLOAuthSignature.h"
#import "NSString+URL.h"
#import "FLObjectDescriber.h"
#import "FLJsonParser.h"

@implementation FLTwitterOperation

@synthesize twitterSession = m_session;

- (void) dealloc
{
	FLRelease(m_session);
	FLSuperDealloc();
}

- (BOOL) willAddParametersToRequestContent:(FLOAuthSignature*) signature
{
	return YES;
}

- (void) willBeginRequestWithNetworkConnection:(FLHttpConnection*) connection
{
	FLOAuthSignature* sig = nil;
	if(m_session)
	{
		sig = [FLOAuthSignature OAuthSignature];
		[sig beginSigningRequest:connection consumerKey:[FLTwitterMgr instance].consumerKey];
		[sig addParameter:kFLOAuthHeaderToken value:m_session.oauth_token];
	}
	
	NSMutableString* content = [NSMutableString string];
	
	if([self willAddParametersToRequestContent:sig])
	{
		if(self.input)
		{
			int count = 0;
			FLObjectDescriber* describer = [[self.input class] sharedObjectDescriber];
			for(NSString* propertyName in describer.propertyDescribers)
			{
				id obj = [self.input valueForKey:propertyName];
				if(obj)
				{
					FLAssert([obj isKindOfClass:[NSString class]], @"not a string"); 
					if(FLStringIsNotEmpty(obj))
					{
						[content appendAndEncodeURLParameter:obj name:propertyName seperator:(count++ == 0 ? @"" : @"&")];
						[sig addParameter:propertyName value:obj];
					}
				}
			}
		}
	}
	
	[connection.httpRequest setFormUrlEncodedContent:content];

	if(sig)
	{
		[sig signRequest:connection withSecret:[NSString stringWithFormat:@"%@&%@", 
			[FLTwitterMgr instance].consumerSecret, 
			m_session.oauth_token_secret]]; //  forURL:self.URL.absoluteString
		[sig addAuthenticationHeaderToRequest:connection oauthParametersOnly:YES];
	}

}

- (NSError*) didCompleteRequestWithNetworkConnection:(FLHttpConnection*) connection
{
	NSError* error = nil;
	
    // this is a hack. In the case of a successfull tweet, it's returning a object containing
    // a bunch of info. In the case of an error, it's returning an error object (FLTwitterError).
    // TODO: refactor this.
    
    FLJsonParser* parser = [FLJsonParser jsonParser];
    NSDictionary* object = [parser parseJsonData:connection.httpResponse.responseData rootObject:nil];
    error = parser.error;
    
    if(!error)
    {
        if([object objectForKey:@"error"])
        {
            error = [NSError errorWithDomain:@"FLTwitterErrorDomain" code:1 localizedDescription:[object objectForKey:@"error"]];
        }
    }

    if(!error)
    {
        error = [connection.httpResponse simpleHttpResponseErrorCheck];
    }
	
	return error;
}
	

@end

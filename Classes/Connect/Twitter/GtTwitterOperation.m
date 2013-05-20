//
//  GtTwitterOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/1/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTwitterOperation.h"
#import "GtOAuthSignature.h"
#import "NSString+URL.h"
#import "GtObjectDescriber.h"
#import "GtJsonParser.h"

@implementation GtTwitterOperation

@synthesize twitterSession = m_session;

- (void) dealloc
{
	GtRelease(m_session);
	GtSuperDealloc();
}

- (BOOL) willAddParametersToRequestContent:(GtOAuthSignature*) signature
{
	return YES;
}

- (void) willBeginRequestWithNetworkConnection:(GtHttpConnection*) connection
{
	GtOAuthSignature* sig = nil;
	if(m_session)
	{
		sig = [[GtOAuthSignature alloc] init];
		[sig beginSigningRequest:connection consumerKey:[GtTwitterMgr instance].consumerKey];
		[sig addParameter:kGtOAuthHeaderToken value:m_session.oauth_token];
	}
	
	NSMutableString* content = [NSMutableString string];
	
	if([self willAddParametersToRequestContent:sig])
	{
		if(self.input)
		{
			int count = 0;
			GtObjectDescriber* describer = [[self.input class] sharedObjectDescriber];
			for(NSString* propertyName in describer.propertyDescribers)
			{
				id obj = [self.input valueForKey:propertyName];
				if(obj)
				{
					GtAssert([obj isKindOfClass:[NSString class]], @"not a string"); 
					if(GtStringIsNotEmpty(obj))
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
			[GtTwitterMgr instance].consumerSecret, 
			m_session.oauth_token_secret]]; //  forURL:self.URL.absoluteString
		[sig addAuthenticationHeaderToRequest:connection oauthParametersOnly:YES];
	
		GtRelease(sig);
	}

}

- (NSError*) didCompleteRequestWithNetworkConnection:(GtHttpConnection*) connection
{
	NSError* error = nil;
	
    // this is a hack. In the case of a successfull tweet, it's returning a object containing
    // a bunch of info. In the case of an error, it's returning an error object (GtTwitterError).
    // TODO: refactor this.
    
    GtJsonParser* parser = [GtJsonParser jsonParser];
    NSDictionary* object = [parser parseJsonData:connection.httpResponse.responseData rootObject:nil];
    error = parser.error;
    
    if(!error)
    {
        if([object objectForKey:@"error"])
        {
            error = [NSError errorWithDomain:@"GtTwitterErrorDomain" code:1 localizedDescription:[object objectForKey:@"error"]];
        }
    }

    if(!error)
    {
        error = [connection.httpResponse simpleHttpResponseErrorCheck];
    }
	
	return error;
}
	

@end

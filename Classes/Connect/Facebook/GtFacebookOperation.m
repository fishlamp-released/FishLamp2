//
//  GtFacebookOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/14/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFacebookOperation.h"
#import "GtJsonNetworkOperationProtocolHandler.h"
#import "GtStringUtils.h"
#import "GtFacebookMgr.h"
#import "NSString+URL.h"
#import "GtFacebookFetchStatusListResponse.h"
#import "GtObjectDescriber.h"
#import "GtJsonParser.h"
#import "GtObjectBuilder.h"

@implementation GtFacebookOperation

@synthesize userId = m_userId;
@synthesize object = m_object;

+ (id) facebookOperation
{
	return GtReturnAutoreleased([[[self class] alloc] init]);
}	

- (void) dealloc
{
	GtRelease(m_userId);
	GtRelease(m_object);
	GtSuperDealloc();
}

- (void) didInit
{
	[super didInit];
	self.userId = [GtFacebookMgr instance].session.userId;
	self.serverContext = [GtFacebookMgr instance];
	self.responseHandler = nil; // [GtJsonNetworkOperationProtocolHandler instance];
	
	self.database = [GtFacebookMgr instance].userSession.cacheDatabase;
	self.cacheBehavior = GtHttpOperationCacheBehaviorNone;
}
- (BOOL) willAddParametersToURL
{
	return YES;
}

- (void) addParametersToURLString:(NSMutableString*) url
{
	if(self.input)
	{
		GtObjectDescriber* describer = [[self.input class] sharedObjectDescriber];
	
		for(NSString* propertyName in describer.propertyDescribers)
		{
			id obj = [self.input valueForKey:propertyName];
			if(obj)
			{
				GtAssert([obj isKindOfClass:[NSString class]], @"not a string"); 
				if(GtStringIsNotEmpty(obj))
				{
					[url appendAndEncodeURLParameter:obj name:propertyName seperator:@"&"];
				}
			}
		}
	}
}


- (NSError*) didCompleteRequestWithNetworkConnection:(GtHttpConnection *)connection
{
	NSError* error = connection.error;
	
	if(!error)
	{
        NSData* responseData = connection.httpResponse.responseData;
    
        GtJsonParser* parser = [GtJsonParser jsonParser];
		NSDictionary* response = [parser parseJsonData:responseData rootObject:nil];
        error = parser.error;
        if(!error)
        {
            if([response objectForKey:@"error"])
            {
                GtLog(@"Got facebook error: %@", [response description]);
            
                error = [NSError errorWithDomain:@"Facebook" code:1 localizedDescription:
                    NSLocalizedString(@"Unexpected Facebook Response", nil)];
            }
            else
            {
                GtObjectBuilder* builder = [[GtObjectBuilder alloc] init];
                [builder buildObjectsFromDictionary:response withRootObject:self.operationOutput];
                GtRelease(builder);
            }
        }
    }
	
	if(!error)
	{
		error = [connection.httpResponse simpleHttpResponseErrorCheck];
	}

	return error;
}

- (NSURL*) createURL
{
	NSMutableString* url = [GtFacebookMgr buildURL:[GtFacebookMgr instance].encodedToken user:self.userId object:self.object params:nil];
	
	
	if([self willAddParametersToURL])
	{
		[self addParametersToURLString:url];
	}
	
	NSURL* URL = [NSURL URLWithString:url];
	GtAssertNotNil(URL);
	
	return URL;
}


@end


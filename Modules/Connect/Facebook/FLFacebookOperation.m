//
//  FLFacebookOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/14/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLFacebookOperation.h"
#import "FLJsonNetworkOperationProtocolHandler.h"
#import "FLStringUtilities.h"
#import "NSString+URL.h"
#import "FLFacebookFetchStatusListResponse.h"
#import "FLObjectDescriber.h"
#import "FLJsonParser.h"
#import "FLObjectBuilder.h"

@implementation FLFacebookOperation

@synthesize userId = m_userId;
@synthesize object = m_object;

+ (id) facebookOperation
{
	return FLReturnAutoreleased([[[self class] alloc] init]);
}	

- (void) dealloc
{
	FLRelease(m_userId);
	FLRelease(m_object);
	FLSuperDealloc();
}

- (void) didInit
{
	[super didInit];
	self.userId = [FLFacebookMgr instance].session.userId;
	self.serverContext = [FLFacebookMgr instance];
	self.responseHandler = nil; // [FLJsonNetworkOperationProtocolHandler instance];
}
- (BOOL) willAddParametersToURL
{
	return YES;
}

- (void) addParametersToURLString:(NSMutableString*) url
{
	if(self.input)
	{
		FLObjectDescriber* describer = [[self.input class] sharedObjectDescriber];
	
		for(NSString* propertyName in describer.propertyDescribers)
		{
			id obj = [self.input valueForKey:propertyName];
			if(obj)
			{
				FLAssert([obj isKindOfClass:[NSString class]], @"not a string"); 
				if(FLStringIsNotEmpty(obj))
				{
					[url appendAndEncodeURLParameter:obj name:propertyName seperator:@"&"];
				}
			}
		}
	}
}


- (NSError*) didCompleteRequestWithNetworkConnection:(FLHttpConnection *)connection
{
	NSError* error = connection.error;
	
	if(!error)
	{
        NSData* responseData = connection.httpResponse.responseData;
    
        FLJsonParser* parser = [FLJsonParser jsonParser];
		NSDictionary* response = [parser parseJsonData:responseData rootObject:nil];
        error = parser.error;
        if(!error)
        {
            if([response objectForKey:@"error"])
            {
                FLDebugLog(@"Got facebook error: %@", [response description]);
            
                error = [NSError errorWithDomain:@"Facebook" code:1 localizedDescription:
                    NSLocalizedString(@"Unexpected Facebook Response", nil)];
            }
            else
            {
                FLObjectBuilder* builder = [[FLObjectBuilder alloc] init];
                [builder buildObjectsFromDictionary:response withRootObject:self.operationOutput];
                FLRelease(builder);
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
	NSMutableString* url = [FLFacebookMgr buildURL:[FLFacebookMgr instance].encodedToken user:self.userId object:self.object params:nil];
	
	
	if([self willAddParametersToURL])
	{
		[self addParametersToURLString:url];
	}
	
	NSURL* URL = [NSURL URLWithString:url];
	FLAssertIsNotNil(URL);
	
	return URL;
}


@end


//
//  GtWsdlOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 8/13/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#import "GtWsdlOperation.h"
#import "GtWsdlServiceManager.h"
#import "GtSoapRequest.h"
#import "GtSoapParser.h"
#import "GtStringUtilities.h"
#import "GtNetworkUtilities.h"
#import "GtErrors.h"
#import "GtSoapFault11.h"
#import "GtDatabaseCache.h"
#import "GtNetworkOperationSecurityManager.h"
#import "GtSoapError.h"
#import "GtError.h"

#import <stdio.h>

@implementation GtWsdlOperation

@synthesize operationID = m_id;
@synthesize delegate = m_delegate;
@synthesize cache = m_cache;
@synthesize previousOperation = m_previousOperation;
@synthesize performCount = m_performCount;
@synthesize error = m_error;

GtSynthesizeStructProperty(shouldPerform, setShouldPerform, BOOL, m_wsdlFlags);
GtSynthesizeStructProperty(canSaveToCache, setCanSaveToCache, BOOL, m_wsdlFlags);
GtSynthesizeStructProperty(canLoadFromCache, setCanLoadFromCache, BOOL, m_wsdlFlags);
GtSynthesizeStructProperty(transportSecurityOverride, setTransportSecurityOverride, GtTransportSecurityOverride, m_wsdlFlags);
GtSynthesizeStructProperty(showNetworkActivityIndicator, setShowNetworkActivityIndicator, BOOL, m_wsdlFlags);
GtSynthesizeStructProperty(isShowingNetworkActivityIndicator, setIsShowingNetworkActivityIndicator, BOOL, m_wsdlFlags);
GtSynthesizeStructProperty(didLoadFromCache, setDidLoadFromCache, BOOL, m_wsdlFlags);

GtSynthesize(prepareCallback, setPrepareCallback, GtSimpleCallback, m_prepareCallback);
GtSynthesize(completedCallback, setCompletedCallback, GtSimpleCallback, m_completedCallback);

GtSynthesizeID(userData, setUserData);
GtSynthesize(reachability, setReachability, GtReachability, m_reachability);
GtSynthesizeIDWithProtocol(cache, setCache, GtDatabaseCacheProtocol); 


static	NSString* m_url = nil;
static	NSString* m_postHeader = nil;
static	NSString* m_targetNamespace = nil;

- (void) onInit
{
	m_id = gtDefaultOperationID;
	self.shouldPerform = YES;
	self.wasPerformed = NO;
	self.canLoadFromCache = YES;
	self.canSaveToCache = YES;
	self.showNetworkActivityIndicator = YES;
	[super onInit];
}

- (void) dealloc
{
	[GtNetworkOperation stopNetworkActivityIndicator:self];

	GtRelease(m_error);
	GtRelease(m_userData);
	GtRelease(m_request);
	GtRelease(m_prepareCallback);
	GtRelease(m_completedCallback);
	GtRelease(m_cache);
    GtRelease(m_reachability);
	
 	[super dealloc];
}

- (BOOL) wasPerformed
{
	return m_wsdlFlags.wasPerformed;
}

- (void) setWasPerformed:(BOOL) wasPerformed
{
	m_wsdlFlags.wasPerformed = wasPerformed;
	if(wasPerformed)
    {
        ++m_performCount;
    }
}

- (void) cancelOperation
{
	m_wsdlFlags.cancel = YES;
	if(m_request)
	{
		[m_request cancel];
	}
}

- (void) resetPerformState
{
	GtReleaseWithNil(m_error);
	GtReleaseWithNil(m_request);
    self.output = nil;
	m_performCount = 0;
	m_wsdlFlags.wasPerformed = NO;
	m_wsdlFlags.cancel = NO;
}

- (BOOL) didSucceed
{
	return self.wasPerformed && m_error == nil && !self.wasCancelled;
}

- (BOOL) wasCancelled
{
	return m_wsdlFlags.cancel;
}

- (void) setError:(NSError*) error
{
	if(error != m_error)
	{
		GtRelease(m_error);
		m_error = [error retain];
	}
	
	if(m_error && m_error.wasCancelled)
	{
		m_wsdlFlags.cancel = error.wasCancelled;
	}
}


- (id) cacheInput
{
	return nil;
}

- (id) input
{
	return nil;
}

- (void) setInput:(id) input
{
}

- (id) output
{
	return nil;
}

- (void) setOutput:(id) input
{
}

- (NSString*) operationName
{
	return nil;
}

- (GtSoapRequest*) createRequest
{
    self.reachability = [GtWsdlServiceManager primaryServiceManager].reachability;

// cache these because they don't change
	if(!m_postHeader)
	{
		m_postHeader = [[GtSoapRequest formatPostHeader:[[GtWsdlServiceManager primaryServiceManager].url urlWithoutRootComponent]] retain];
	}
	if(!m_url)
	{
		m_url = [[[GtWsdlServiceManager primaryServiceManager] url] retain];
	}
	if(!m_targetNamespace)
	{
		m_targetNamespace = [[[GtWsdlServiceManager primaryServiceManager] targetNamespace] retain];
	}
	
// variable values
	NSString* functionName = [self operationName];
	GtAssertIsValidString(functionName);

	NSString* soapAction = [[GtWsdlServiceManager primaryServiceManager] valueForKey:functionName];
	GtAssertIsValidString(soapAction);
	
	GtSoapRequest* request = nil;
		
	@try
	{
		request = [GtAlloc(GtSoapRequest) initWithSoapInfo: m_url
									postHeader: m_postHeader
									soapActionHeader: soapAction
									soapApiNamespace: m_targetNamespace 
									];
	
		
		[request addObjectAsFunction:functionName object:self.input];
		
		request.delegate = self;
		
		if([[GtNetworkOperationSecurityManager instance] operationIsSecure:self])
		{
			if([GtWsdlServiceManager primaryServiceManager].webRequestSecurityHandler)
			{
				[[GtWsdlServiceManager primaryServiceManager].webRequestSecurityHandler onAddSecurityToRequest:request operation:self];
			}
			else
			{
				GtThrowFishLampException(@"Request requires security handler");
			}
		}
	}
	@catch(NSException* ex)
	{
		GtRelease(request);
		request = nil;
		@throw;
	}
	
	return request;
}

#define MAX_ERR_LEN 500

- (BOOL) doErrorCheck:(NSData*) data
{
	char* first = strnstr((const char*) [data bytes], "Fault", MIN([data length], MAX_ERR_LEN));
	if(first)
	{
		GtSoapFault11* soapFault = [GtAlloc(GtSoapFault11) initWithXmlParseKey:@"fault"]; // TODO maybe cache this until it's used?
		GtSoapParser* parser = [GtAlloc(GtSoapParser) initWithIgnoreEnvelopeAndBody:YES];
		parser.stopOnMissingData = YES;
		@try
		{
			[parser parse:data object:soapFault];

			NSError* error = [GtAlloc(NSError) initWithSoapFault:soapFault];
			self.error = error;
			GtRelease(error);
			
			GtLog(@"Got Soap Fault:\n%@", [soapFault description]);
		}
		@finally
		{
			GtRelease(parser);
			GtRelease(soapFault);
		}
		return YES;
	}
	
	return NO;
}

- (void) parseXmlResponse:(NSData*) data 
	object:(GtSerializableObject*) object
{
	GtSoapParser* parser = [GtAlloc(GtSoapParser) initWithIgnoreEnvelopeAndBody:YES];
	@try
	{
		[parser parse:data object:object];
	}
	@finally
	{
		GtRelease(parser);
	}
}

- (void) networkRequest:(GtNetworkRequest *) request 
	didSendBodyData:(NSInteger)bytesWritten 
	totalBytesWritten:(NSInteger)totalBytesWritten 
	totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
	if(self.delegate)
	{
		[self.delegate operation:self
			operationDidSendBytes:bytesWritten
			totalBytesWritten:totalBytesWritten
			totalBytesExpectedToWrite:totalBytesExpectedToWrite];
	}
}

- (BOOL) onPrepareOperationInMainThread
{
	return [GtNetworkOperation sharedPrepareOperationInMainThread:self];
}

- (BOOL) onWillPerformOperation
{
	return [GtNetworkOperation sharedWillPerformOperation:self];
}

- (void) onPerformOperation 
{
	GtReleaseWithNil(m_request);

	m_request = [self createRequest];

	[m_request send];
	
	if(!self.wasCancelled)
	{
		self.error = m_request.error; // if there is a soap fault, this will get deleted.
			
		NSData* data = [m_request receivedData];
		if(![self doErrorCheck:data])
		{
			id output = [self output];
			[self parseXmlResponse:data object:output];
			[m_request simpleHttpResponseErrorCheck];
		}
	}
}

- (void) onOperationWasPerformed
{
	[GtNetworkOperation sharedFinalizeOperation:self];
}

- (void) perform
{
	[GtOperation sharedPerformOperation:self];
}

- (id<GtNetworkRequestProtocol>) networkRequest
{
	return m_request;
}

- (void) setNetworkRequest:(id<GtNetworkRequestProtocol>) request
{
	if(request != m_request)
	{
		GtRelease(m_request);
		m_request = [request retain];
	}
}

- (void) onConvertOperationInputToCacheInput:(id*) outCacheInput;
{
}

- (void) onSetOperationOutputWithCacheOutput:(id) cacheOutput;
{
	self.output = cacheOutput;
}

- (void) onConvertOperationOutputToCachedObject:(id*) outCachedObject
{
}

- (BOOL) preLoadOperationOutputFromCache:(id<GtDatabaseCacheProtocol>) cache
{
	return [GtNetworkOperation sharedLoadOperationOutputFromCache:cache
		operation:self
		isPreLoad:YES];
}

- (BOOL) loadOperationOutputFromCache:(id<GtDatabaseCacheProtocol>) cache
{
	return [GtNetworkOperation sharedLoadOperationOutputFromCache:cache
		operation:self
		isPreLoad:NO];
}

- (void) saveOperationOutputToCache:(id<GtDatabaseCacheProtocol>) cache
{
	[GtNetworkOperation sharedSaveOperationOutputToCache:cache
		operation:self];
}

- (BOOL) didFail
{
    return self.wasPerformed && m_error != nil;
}

- (BOOL) didTimeout
{
    return self.wasPerformed && m_error && m_error.code == NSURLErrorTimedOut;
}

- (BOOL) didLoseNetwork
{
   return self.wasPerformed && m_error && m_error.didLoseNetwork;
}

- (BOOL) canRetryOnFailure
{
    return  self.didTimeout ||
            self.didLoseNetwork ||
            self.error.isOsNetworkingErrorBug;
}


@end

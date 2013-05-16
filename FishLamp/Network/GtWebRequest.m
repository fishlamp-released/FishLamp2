//
//  GtWebServiceRequest.m
//  FishLamp
//
//  Created By Mike Fullerton on 4/20/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#import "GtWebRequest.h"
#import "GtFileUtilities.h"
#import "GtDevice.h"

@implementation GtWebRequest

GtAssertDefaultInitNotCalled();

GtSynthesizeString(postHeader, setPostHeader);

-(id) initGetRequestWithUrl:(NSString*) url
{
	if(self = [super initWithUrl:url])
	{
		m_isPostRequest = NO;
		[self.request setHTTPMethod:@"GET"];
		[self.request setHTTPShouldHandleCookies:NO];

        
       	[self addDefaultUserAgent];

	}
	return self;
}

-(id) initPostRequestWithUrl:(NSString*) url
	postHeader:(NSString*) postHeader
{	
	GtAssertIsValidString(url);

	if(self = [super initWithUrl:url])
	{
		self.postHeader = postHeader;
		
		m_isPostRequest = YES;
		[self.request setHTTPMethod:@"POST"];
		[self.request setHTTPShouldHandleCookies:NO];
        
      	[self addDefaultUserAgent];

	}
	return self;
}

-(void) addHeader:(NSString*)headerName data:(NSString*)data
{
	[self.request addValue:data forHTTPHeaderField:headerName];
}

-(void) setUtf8Content:(NSString*) content
{
	[self setContentWithData:@"text/xml; charset=utf-8" 
			 		 content:[content dataUsingEncoding:NSUTF8StringEncoding]]; // TODO don't autorelease this
}

-(void) addContentTypeHeader:(NSString*) contentType
{
	[self addHeader:@"Content-Type" data:contentType];
}

-(void) addContentLengthHeader:(NSUInteger) length
{
	NSString* contentLength = [GtAlloc(NSString) initWithFormat:@"%d", length];
	[self addHeader:@"Content-Length" data:contentLength];
	GtRelease(contentLength);
}

-(void) setContentWithData:(NSString*) typeContentHeader 
		           content:(NSData*) content
{
	[self.request setHTTPBody:content];
	[self addContentTypeHeader:typeContentHeader];
	[self addContentLengthHeader:[content length]];
}

-(void) setContentWithFilePath:(NSString*) typeContentHeader 
					  filePath:(NSString*) path
{
	[self addContentTypeHeader:typeContentHeader];
	
	unsigned long fileSize = [GtFileUtilities fileSize:path];
	
	[self addContentLengthHeader:fileSize];
	
	NSInputStream* stream = [GtAlloc(NSInputStream) initWithFileAtPath:path]; 
	[self.request setHTTPBodyStream:stream];
    GtRelease(stream);
}

-(void) dealloc
{
	GtRelease(m_postHeader);

	[super dealloc];
}

- (void) simpleHttpResponseErrorCheck 
{
	if(self.error == nil)
	{
		NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*) self.response;
		
		NSInteger statusCode = [httpResponse statusCode];
		if(statusCode >= 400)
		{
            NSDictionary *errorInfo
              = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:
                  NSLocalizedString(@"Server returned status code %d",@""),
                    statusCode]
                    forKey:NSLocalizedDescriptionKey];
        
            NSError* error = [GtAlloc(NSError) initWithDomain:@"FishLampErrorDomain" 
                code:statusCode
                userInfo:errorInfo];
			self.error = error;
            GtRelease(error);
		}
	}
}

- (void) addHostHeader:(NSString*) host
{
	GtAssertIsValidString(host);

	[self addHeader:@"HOST" data:host];
}

- (void) addUserAgentHeader:(NSString*) userAgent
{
	GtAssertIsValidString(userAgent);

	[self addHeader:@"User-Agent" data:userAgent];
}

+ (NSString*) defaultUserAgent
{
	static NSString* s_userAgent = nil;
	if(!s_userAgent)
	{
		@synchronized(s_userAgent)
		{
			if(!s_userAgent)
			{
				s_userAgent = [GtAlloc(NSString) initWithFormat:@"%@/%@ (%@; %@; %@; %@;)", 
					[GtFileUtilities appName], 
					[GtFileUtilities appVersion],
					[UIDevice currentDevice].model,
					[UIDevice currentDevice].machineName,
					[UIDevice currentDevice].systemName,
					[UIDevice currentDevice].systemVersion];
			}
		}
	}

	return s_userAgent;
}

- (void) addDefaultUserAgent
{
	[self addUserAgentHeader:[GtWebRequest defaultUserAgent]];
}

- (void) addBasicHeaders
{
	if(self.postHeader)
	{
		[self addHeader:@"POST" data:self.postHeader];
	}
		
	[self addHostHeader:self.host];
}

- (void) addImageContentWithFilePath:(NSString*) filePath
{
	GtAssertIsValidString(filePath);

	[self setContentWithFilePath:@"image/jpeg" filePath:filePath];
}

- (void) addImageContentWithData:(NSData*) imageData
{
	GtAssertNotNil(imageData);
	GtAssert(imageData.length > 0, @"Empty data");
	
	[self setContentWithData:@"image/jpeg" content:imageData];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self simpleHttpResponseErrorCheck];
    [super connectionDidFinishLoading:connection];
}

/*
- (void) connection:(NSURLConnection *)connection 
 didReceiveResponse:(NSURLResponse *)response
{
 	int statusCode = [((NSHTTPURLResponse *)response) statusCode];

#if DEBUG
	GtTrace(GtTraceNetworkRequests, @"web connection did receive response, server status code: %d", statusCode);
#endif

  	if (statusCode >= 400)
	{	
		NSDictionary *errorInfo
		  = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:
			  NSLocalizedString(@"Server returned status code %d",@""),
				statusCode]
				forKey:NSLocalizedDescriptionKey];
    
		NSError* error = [GtAlloc(NSError) initWithDomain:@"FishLampErrorDomain" 
			code:statusCode
			userInfo:errorInfo];
			
		[self connection:connection didFailWithError:error];
	}
	else
	{
		[super connection:connection didReceiveResponse:response];
	}
}
*/

  

@end

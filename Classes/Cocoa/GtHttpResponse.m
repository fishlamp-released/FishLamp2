//
//  GtHttpResponse.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/23/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtHttpResponse.h"

@implementation GtHttpResponse

@synthesize responseData = m_responseData;
@synthesize responseStatusCode = m_responseStatusCode;
@synthesize responseHeaders = m_responseHeaders;
@synthesize responseStatusLine = m_responseStatusLine;

- (id) init
{
    if((self = [super init]))
    {
        m_responseData = [[NSMutableData alloc] init];
    }
    
    return self;
}

- (void) dealloc 
{
    GtRelease(m_responseStatusLine);
    GtRelease(m_responseHeaders);
    GtRelease(m_responseData);
    GtSuperDealloc();
}

- (NSError*) simpleHttpResponseErrorCheck 
{
	NSInteger statusCode = self.responseStatusCode;
	if(statusCode >= 400)
	{
		NSDictionary *errorInfo
		  = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:
			  (NSLocalizedString(@"Server returned error code:%d (%@). Status line: %@",nil)),
				statusCode,
				[NSHTTPURLResponse localizedStringForStatusCode:statusCode],
                m_responseStatusLine == nil ? @"" : m_responseStatusLine
				]
				forKey:NSLocalizedDescriptionKey];
	
	   return GtReturnAutoreleased([[NSError alloc] initWithDomain:GtErrorDomain 
			code:statusCode
			userInfo:errorInfo]);
	}

	return nil;
}

- (NSString*) headerValue:(NSString*) header
{
    return [m_responseHeaders objectForKey:header];
}

// http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html

- (BOOL) responseCodeIsRedirect
{
    switch(self.responseStatusCode)
    {
        case 301: // Moved Permanently.
        case 302: // Found.
        case 304: // Not Modified.
        case 307: // Temporary Redirect.
            return YES;
            break;
    }
    
    return NO;
}        

- (BOOL) wantsRedirect
{
    return self.responseCodeIsRedirect && GtStringIsNotEmpty([self headerValue:@"Location"]); 
}


@end

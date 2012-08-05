//
//  FLHttpResponse.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/23/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLHttpResponse.h"

@implementation FLHttpResponse

@synthesize responseData = _responseData;
@synthesize responseStatusCode = _responseStatusCode;
@synthesize responseHeaders = _responseHeaders;
@synthesize responseStatusLine = _responseStatusLine;

- (id) init
{
    if((self = [super init]))
    {
        _responseData = [[NSMutableData alloc] init];
    }
    
    return self;
}

- (void) dealloc 
{
    FLRelease(_responseStatusLine);
    FLRelease(_responseHeaders);
    FLRelease(_responseData);
    FLSuperDealloc();
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
                _responseStatusLine == nil ? @"" : _responseStatusLine
				]
				forKey:NSLocalizedDescriptionKey];
	
	   return FLReturnAutoreleased([[NSError alloc] initWithDomain:FLErrorDomain 
			code:statusCode
			userInfo:errorInfo]);
	}

	return nil;
}

- (NSString*) headerValue:(NSString*) header
{
    return [_responseHeaders objectForKey:header];
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
    return self.responseCodeIsRedirect && FLStringIsNotEmpty([self headerValue:@"Location"]); 
}


@end

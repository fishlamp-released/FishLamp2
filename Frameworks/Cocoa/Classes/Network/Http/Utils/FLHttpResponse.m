//
//  FLHttpResponse.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/23/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLHttpResponse.h"
#import "FLHttpMessage.h"

@interface FLHttpResponse ()
@property (readwrite, strong, nonatomic) NSDictionary* responseHeaders;
@property (readwrite, assign, nonatomic) NSInteger responseStatusCode;
@property (readwrite, strong, nonatomic) NSString* responseStatusLine;
@property (readwrite, strong, nonatomic) FLHttpResponse* redirectedFrom;
@property (readwrite, strong, nonatomic) NSURL* requestURL;
@property (readwrite, strong, nonatomic) id<FLInputSink> inputSink;
@end

@implementation FLHttpResponse

@synthesize responseStatusCode = _responseStatusCode;
@synthesize responseHeaders = _responseHeaders;
@synthesize responseStatusLine = _responseStatusLine;
@synthesize requestURL = _requestURL;
@synthesize redirectedFrom = _redirectedFrom;
@synthesize inputSink = _inputSink;

- (id) initWithRequestURL:(NSURL*) url 
                  headers:(FLHttpMessage*) headers 
           redirectedFrom:(FLHttpResponse*) redirectedFrom 
                inputSink:(id<FLInputSink>) inputSink {

    if((self = [super init])) {
        self.requestURL = url;
        self.redirectedFrom = redirectedFrom;
        self.responseHeaders = headers.allHeaders;
        self.responseStatusLine = headers.responseStatusLine;
        self.responseStatusCode = headers.responseStatusCode;
        self.inputSink = inputSink;
    }
    
    return self;
}

+ (id) httpResponse:(NSURL*) requestURL 
            headers:(FLHttpMessage*) headers 
     redirectedFrom:(FLHttpResponse*) redirectedFrom 
                inputSink:(id<FLInputSink>) inputSink {

    return FLAutorelease([[[self class] alloc] initWithRequestURL:requestURL 
                                                          headers:(FLHttpMessage*) headers 
                                                   redirectedFrom:redirectedFrom 
                                                    inputSink:inputSink]);
}

- (NSData*) responseData {
    return [self.inputSink data];
}

- (NSURL*) responseFileURL {
    return [self.inputSink fileURL];
}

#if FL_MRC
- (void) dealloc {
    [_inputSink release];
    [_redirectedFrom release];
    [_requestURL release];
    [_responseStatusLine release];
    [_responseHeaders release];
    [super dealloc];
}
#endif

- (NSError*) simpleHttpResponseErrorCheck {
	NSInteger statusCode = self.responseStatusCode;
	if(statusCode >= 400) {
	
        NSString* errorString = [NSString stringWithFormat:
			  (NSLocalizedString(@"Server returned error code:%d (%@). Status line: %@",nil)),
				statusCode,
				[NSHTTPURLResponse localizedStringForStatusCode:statusCode],
                _responseStatusLine == nil ? @"" : _responseStatusLine];

    
	   return [NSError errorWithDomain:FLFrameworkErrorDomain
                                  code:statusCode
                  localizedDescription:errorString];
	}

	return nil;
}
- (void) throwHttpErrorIfNeeded {
    FLThrowIfError([self simpleHttpResponseErrorCheck]);
}

- (NSString*) valueForHeader:(NSString*) header {
    return [_responseHeaders objectForKey:header];
}

//- (id)copyWithZone:(NSZone *)zone {
//    FLHttpResponse* response = [[FLHttpResponse alloc] initWithRequestURL:self.requestURL];
//    response.responseHeaders = self.responseHeaders;
//    response.responseStatusCode = self.responseStatusCode;
//    response.redirectedFrom = self.redirectedFrom;
//    response.networkStreamSink = FLAutorelease([self.networkStreamSink copyWithNoData]);
//    response.responseStatusLine = self.responseStatusLine;
//    return response;
//}

- (NSString*) description {
//    NSMutableString* string = [self headers]
    
    NSMutableString* desc = [NSMutableString stringWithFormat:@"%@\r\n", [super description]];
    [desc appendFormat:@"request URL:%@\r\n",  [_requestURL description]];
    [desc appendFormat:@"response status line: \"%@\"\r\nresponse code: %d\r\n", _responseStatusLine, (int)_responseStatusCode];
    [desc appendFormat:@"response headers: %@\r\n",  [_responseHeaders description]];
    
    if(self.redirectedFrom) {
        [desc appendFormat:@"redirected from: %@\r\n", [self.redirectedFrom description]];
    }

    return desc;
}

- (void) setResponseHeadersWithHttpMessage:(FLHttpMessage*) message {
}

@end


@implementation  FLHttpResponse (Utils)
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

- (BOOL) wantsRedirect {
    return self.responseCodeIsRedirect && FLStringIsNotEmpty([self valueForHeader:@"Location"]); 
}

- (NSURL*) redirectURL {
    return [NSURL URLWithString:[self valueForHeader:@"Location"] relativeToURL:self.requestURL];
}
@end

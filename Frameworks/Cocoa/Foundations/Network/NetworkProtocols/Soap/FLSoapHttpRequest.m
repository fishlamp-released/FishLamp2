//
//  FLSoapHttpRequest.m
//  FLCore
//
//  Created by Mike Fullerton on 11/4/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLSoapHttpRequest.h"
#import "FLSoapParser.h"
#import "FLSoapError.h"
#import "FLSoapFault11.h"
#import "FLSoapStringBuilder.h"

@implementation FLSoapHttpRequest 

@synthesize soapRequest = _soapRequest;
@synthesize soapResponse = _soapResponse;
@synthesize soapActionHeader = _soapActionHeader;
@synthesize soapNamespace = _soapNamespace;
@synthesize operationName = _operationName;
@synthesize responseDecoder = _responseDecoder;

#if FL_MRC
- (void) dealloc {
    [_soapRequest release];
    [_soapResponse release];
    [_responseDecoder release];
    [_soapActionHeader release];
    [_operationName release];
    [_soapNamespace release];
    [super dealloc];
}
#endif

#define MAX_ERR_LEN 500

+ (FLSoapFault11*) checkForSoapFaultInData:(NSData*) data {
	if(data && data.length >0 ) {
		char* first = strnstr((const char*) [data bytes], "Fault", MIN([data length], (unsigned int) MAX_ERR_LEN));
		if(first) {
			FLSoapFault11* soapFault = [FLSoapFault11 soapFault11];
			FLSoapParser* soapParser = [[FLSoapParser alloc] initWithXmlData:data];

			@try {
				[soapParser buildObjects:soapFault];
				FLDebugLog(@"Soap Fault:%@/%@", [soapFault faultcode], [soapFault faultstring]);
			}
			@finally {
				FLRelease(soapParser);
			}
            return soapFault;
		}
	}

	return nil;
}

- (void) parseXmlResponse:(NSData*) data object:(id) object {
	FLSoapParser* soapParser = [[FLSoapParser alloc] initWithXmlData:data];
	@try {
		[soapParser buildObjects:object];
	}
	@finally {
		FLRelease(soapParser);
	}
}

- (void) handleSoapFault:(FLSoapFault11*) fault {
    FLThrowError([NSError errorWithSoapFault:fault]);
}

- (void) willSendHttpRequest {
    FLAssertStringIsNotEmpty_(self.headers.requestURL.absoluteString);
    FLAssertStringIsNotEmpty_(self.soapNamespace);
    FLAssertStringIsNotEmpty_(self.operationName);

// wehre is http request url?
    FLSoapStringBuilder* soapStringBuilder = [FLSoapStringBuilder soapStringBuilder];
    
    FLObjectXmlElement* element = [FLObjectXmlElement soapXmlElementWithObject:self.soapRequest 
                                                                 xmlElementTag:self.operationName
                                                                  xmlNamespace:self.soapNamespace];
            
	[soapStringBuilder addElement:element];

    [self.headers setValue:self.soapActionHeader forHTTPHeaderField:@"SOAPAction"]; 
    [self.body setUtf8Content:[FLStringBuilder buildStringWithNoWhiteSpace:soapStringBuilder]];
    
#if DEBUG
    self.body.debugBody = [FLStringBuilder buildString:soapStringBuilder];
//    FLLog([self description]);
#endif    
}

- (id) didReceiveHttpResponse:(FLHttpResponse*) httpResponse {
    NSData* data = httpResponse.responseData;
    
    FLSoapFault11* fault = [FLSoapHttpRequest checkForSoapFaultInData:data];
    if(fault) {
        [self handleSoapFault:fault];
    }
    
    [httpResponse throwHttpErrorIfNeeded];
   
    id result = data;
   
    if(self.soapResponse) {
        [self parseXmlResponse:data object:self.soapResponse];
        result = self.soapResponse;
        
#if DEBUG
        httpResponse.debugResponseData = result;
#endif        
    }
    
    if(self.responseDecoder) {
        result = self.responseDecoder(result);
    }
    
    return result;
}

@end



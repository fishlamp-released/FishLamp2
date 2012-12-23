//
//  FLSoapOperation.m
//  FLCore
//
//  Created by Mike Fullerton on 11/4/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLSoapOperation.h"
#import "FLSoapParser.h"
#import "FLSoapError.h"
#import "FLSoapFault11.h"
#import "FLSoapStringBuilder.h"

@implementation FLSoapOperation 

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

- (FLResult) runOperationWithInput:(id) input {

    FLAssertStringIsNotEmpty_(self.httpRequestURL.absoluteString);
    FLAssertStringIsNotEmpty_(self.soapNamespace);
    FLAssertStringIsNotEmpty_(self.operationName);

    FLSoapStringBuilder* soap = [FLSoapStringBuilder stringBuilder];
	[soap.body addObjectAsFunction:self.operationName object:[self soapRequest] xmlNamespace:self.soapNamespace];

    FLHttpRequest* request = [FLHttpRequest httpPostRequestWithURL:self.httpRequestURL];
    [request.httpHeaders setValue:self.soapActionHeader forHTTPHeaderField:@"SOAPAction"]; 
    [request.httpBody setUtf8Content:[soap buildStringWithNoWhitespace]];

    FLHttpResponse* httpResponse = [self sendHttpRequest:request];

    NSData* data = httpResponse.responseData;
    
    FLSoapFault11* fault = [FLSoapOperation checkForSoapFaultInData:data];
    if(fault) {
        [self handleSoapFault:fault];
    }
    
    FLThrowError([httpResponse simpleHttpResponseErrorCheck]);
   
    id result = data;
   
    if(self.soapResponse) {
        [self parseXmlResponse:data object:self.soapResponse];
        result = self.soapResponse;
    }
    
    if(self.responseDecoder) {
        result = self.responseDecoder(result);
    }
    
    return result;
}

@end



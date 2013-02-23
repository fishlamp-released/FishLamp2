//
//  FLSoapHttpRequest.m
//  FLCore
//
//  Created by Mike Fullerton on 11/4/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLSoapHttpRequest.h"
#import "FLSoapObjectBuilder.h"
#import "FLSoapError.h"
#import "FLSoapFault11.h"
#import "FLSoapStringBuilder.h"
#import "FLSoapDataEncoder.h"

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
			FLSoapObjectBuilder* soapParser = [FLSoapObjectBuilder soapObjectBuilder];
			FLSoapFault11* soapFault = [soapParser buildObjectWithClass:[FLSoapFault11 class] withData:data withDataDecoder:[FLSoapDataEncoder instance]];
            
			FLDebugLog(@"Soap Fault:%@/%@", [soapFault faultcode], [soapFault faultstring]);
            return soapFault;
		}
	}

	return nil;
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
    
    FLPrettyString* soapString = [FLPrettyString prettyString:nil];
    [soapString appendBuildableString:soapStringBuilder];

    [self.body setUtf8Content:soapString.string];
    
#if DEBUG
    FLPrettyString* debugString = [FLPrettyString prettyString];
    [debugString appendBuildableString:soapStringBuilder];

    self.body.debugBody = debugString.string;
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
        FLSoapObjectBuilder* soapParser = [FLSoapObjectBuilder soapObjectBuilder];
        result = [soapParser buildObjectWithClass:[self.soapResponse class] 
                                         withData:data 
                                  withDataDecoder:[FLSoapDataEncoder instance]];
    
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



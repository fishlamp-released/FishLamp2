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
#import "FLSoapParser.h"


@implementation FLSoapHttpRequest 

@synthesize soapInput = _soapInput;
@synthesize soapActionHeader = _soapActionHeader;
@synthesize soapNamespace = _soapNamespace;
@synthesize operationName = _operationName;
@synthesize handleSoapResponseBlock = _handleSoapResponseBlock;

#if FL_MRC
- (void) dealloc {
    [_handleSoapResponseBlock release];
    [_soapInput release];
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
            FLParsedItem* soap = [[FLSoapParser soapParser] parseData:data];
    
            FLSoapFault11* soapFault = [[FLSoapObjectBuilder instance] buildObjectWithType:[FLSoapFault11 type] withSoap:soap];
            FLAssertNotNil_(soapFault);
    
//			FLSoapObjectBuilder* soapParser = [FLSoapObjectBuilder soapObjectBuilder];
//			FLSoapFault11* soapFault = [soapParser buildObjectWithClass:[FLSoapFault11 class] withData:data withDataDecoder:[FLSoapDataEncoder instance]];
            
			FLDebugLog(@"Soap Fault:%@/%@", [soapFault faultcode], [soapFault faultstring]);
            return soapFault;
		}
	}

	return nil;
}

- (NSError*) createErrorForSoapFault:(FLSoapFault11*) fault {
    return nil;
}

- (void) willSendHttpRequest {
    FLAssertStringIsNotEmpty_(self.headers.requestURL.absoluteString);
    FLAssertStringIsNotEmpty_(self.soapNamespace);
    FLAssertStringIsNotEmpty_(self.operationName);

    FLSoapStringBuilder* soapStringBuilder = [FLSoapStringBuilder soapStringBuilder];
    
    FLObjectXmlElement* element = [FLObjectXmlElement soapXmlElementWithObject:self.soapInput 
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

- (NSError*) checkHttpResponseForError:(FLHttpResponse*) httpResponse {
    NSData* data = httpResponse.responseData;
    
    FLSoapFault11* fault = [FLSoapHttpRequest checkForSoapFaultInData:data];
    if(fault) {
        NSError* error = [self createErrorForSoapFault:fault];
        if(!error) {
            error = [NSError errorWithSoapFault:fault];
        }
        
        return error;
    }
    
    return [super checkHttpResponseForError:httpResponse];
}


- (FLResult) resultFromHttpResponse:(FLHttpResponse*) httpResponse {
    NSData* data = httpResponse.responseData;

    FLParsedItem* parsedSoap = [[FLSoapParser soapParser] parseData:data];
    
    if(_handleSoapResponseBlock) {
        return _handleSoapResponseBlock(parsedSoap);
    }
    
    return parsedSoap;
}

@end



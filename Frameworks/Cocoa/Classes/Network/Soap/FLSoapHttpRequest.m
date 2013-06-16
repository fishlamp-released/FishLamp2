//
//  FLSoapHttpRequest.m
//  FLCore
//
//  Created by Mike Fullerton on 11/4/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLSoapHttpRequest.h"
#import "FLSoapObjectBuilder.h"
#import "FLSoapError.h"
#import "FLSoapFault11.h"
#import "FLSoapStringBuilder.h"
#import "FLSoapDataEncoder.h"
#import "FLSoapParser.h"
#import "FLObjectDescriber.h"
#import "FLSoapFault11.h"
#import "FLStringEncoder.h"
#import "FLParsedXmlElement.h"
#import "FLHttpRequestDescriptor.h"
#import "FLHttpResponse.h"
#import "FLHttpRequestBody.h"

#define TRACE 0

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

//- (id) soapInput {
//    return _soapInput != nil ? _soapInput : self.requestDescriptor.input;
//}
//
//- (NSString*) soapActionHeader {
//    return FLStringIsNotEmpty(_soapActionHeader) ? _soapActionHeader : self.requestDescriptor.soapAction;
//}
//
//- (NSString*) soapNamespace {
//    return FLStringIsNotEmpty(_soapNamespace) ? _soapNamespace : self.requestDescriptor.targetNamespace;
//}
//
//- (NSString*) operationName {
//    return FLStringIsNotEmpty(_operationName) ? _operationName : self.requestDescriptor.operationName;
//}

#define MAX_ERR_LEN 500

+ (FLSoapFault11*) checkForSoapFaultInData:(NSData*) data {
	if(data && data.length >0 ) {
		char* first = strnstr((const char*) [data bytes], "Fault", MIN([data length], (unsigned int) MAX_ERR_LEN));
        if(first) {
            FLParsedXmlElement* soap = [[FLSoapParser soapParser] parseData:data];
            
            FLSoapFault11* soapFault = [FLSoapFault11 objectWithXmlElement:soap 
                                                               elementName:@"Fault"
                                                         withObjectBuilder:[FLSoapObjectBuilder instance]];
            
            FLAssertNotNil(soapFault);
			FLLog(@"Soap Fault:%@/%@", [soapFault faultcode], [soapFault faultstring]);
            return soapFault;
		}
	}

	return nil;
}

- (NSError*) createErrorForSoapFault:(FLSoapFault11*) fault {
    return nil;
}

- (void) willSendHttpRequest {
    FLAssertStringIsNotEmpty(self.requestHeaders.requestURL.absoluteString);
    FLAssertStringIsNotEmpty(self.soapNamespace);
    FLAssertStringIsNotEmpty(self.operationName);

    FLSoapStringBuilder* soapStringBuilder = [FLSoapStringBuilder soapStringBuilder];
    
    FLObjectXmlElement* element = [FLObjectXmlElement soapXmlElementWithObject:self.soapInput 
                                                                 xmlElementTag:self.operationName
                                                                  xmlNamespace:self.soapNamespace];
            
	[soapStringBuilder addElement:element];
    NSString* soap = [soapStringBuilder buildStringWithNoWhitespace];

    [self.requestHeaders setValue:self.soapActionHeader forHTTPHeaderField:@"SOAPAction"]; 
    [self.requestBody setUtf8Content:soap];
    
#if DEBUG
    FLPrettyString* debugString = [FLPrettyString prettyString];
    [debugString appendBuildableString:soapStringBuilder];

    self.requestBody.debugBody = debugString.string;
    
#if TRACE
//    FLTrace(@"Soap Request:"); 
    
    FLLogIndent(^{
        FLLog([self.requestHeaders description]);
        FLLog([self.requestBody description]);
    });
    
    
//    , [self requestHeaders]);
//    FLTrace(@"%@", debugString.string);
#endif    
    
//    FLLog([self description]);
#endif    
}

- (NSError*) checkHttpResponseForError:(FLHttpResponse*) httpResponse {

    [httpResponse.responseData closeSinkWithCommit:YES];
    
    NSData* data = httpResponse.responseData.data;
    FLAssertNotNil(data);
    
    FLSoapFault11* fault = [FLSoapHttpRequest checkForSoapFaultInData:data];
    if(fault) {
        NSError* error = [self createErrorForSoapFault:fault];
        if(!error) {
            error = [NSError errorWithSoapFault:fault];
        }
#if DEBUG
        FLLog(@"Soap Fault: %@", [fault description]);
#endif
        
        return error;
    }
    
    return [super checkHttpResponseForError:httpResponse];
}


- (id) resultFromHttpResponse:(FLHttpResponse*) httpResponse {
    NSData* data = [httpResponse.responseData data];
    FLAssertNotNil(data);

#if TRACE
    FLLog(@"Soap Response:");
    FLLog([[httpResponse responseHeaders] description]);
    FLLog(FLAutorelease([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]));
#endif    

    FLParsedXmlElement* parsedSoap = [[FLSoapParser soapParser] parseData:data];
    
    if(_handleSoapResponseBlock) {
        return _handleSoapResponseBlock(parsedSoap);
    }
    
    return parsedSoap;
}

@end



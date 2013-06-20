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
#import "FLHttpRequest.h"

#define TRACE 0

@implementation FLSoapHttpRequest 

#define MAX_ERR_LEN 500

- (id) init {	
    return [self initWithRequestURL:[NSURL URLWithString:self.location] httpMethod:@"POST"];
}

+ (id) soapRequest {
    return FLAutorelease([[[self class] alloc] init]);
}
- (NSString*) location {
    return nil;
}

- (NSString*) soapAction {
    return nil;
}
- (NSString*) targetNamespace {
    return nil;
}
- (NSString*) operationName {
    return nil;
}
- (id) input {
    return nil;
}
- (id) output {
    return nil;
}

- (id) initWithRequestURL:(NSURL*) url httpMethod:(NSString*) httpMethod {
    self = [super init];
    if(self) {
        _url = FLRetain(url);
        _httpMethod = FLRetain(httpMethod);
    }

    return self;
}

+ (id) soapRequestWithURL:(NSURL*) url
               httpMethod:(NSString*) httpMethod {
    return FLAutorelease([[[self class] alloc] init]);
}

- (NSURL*) httpRequestURL {
    return _url;
}

- (NSString*) httpRequestHttpMethod {
    return _httpMethod;
}

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

- (void) httpRequestWillOpen:(FLHttpRequest*) httpRequest {
    FLAssertStringIsNotEmpty(httpRequest.requestHeaders.requestURL.absoluteString);
    FLAssertStringIsNotEmpty(self.targetNamespace);
    FLAssertStringIsNotEmpty(self.operationName);

    FLSoapStringBuilder* soapStringBuilder = [FLSoapStringBuilder soapStringBuilder];
    
    FLObjectXmlElement* element = [FLObjectXmlElement soapXmlElementWithObject:self.input
                                                                 xmlElementTag:self.operationName
                                                                  xmlNamespace:self.targetNamespace];
            
	[soapStringBuilder addElement:element];
    NSString* soap = [soapStringBuilder buildStringWithNoWhitespace];

    [httpRequest.requestHeaders setValue:self.soapAction forHTTPHeaderField:@"SOAPAction"];
    [httpRequest.requestBody setUtf8Content:soap];
    
//#if DEBUG
//    FLPrettyString* debugString = [FLPrettyString prettyString];
//    [debugString appendBuildableString:soapStringBuilder];
//
//    httpRequest.requestBody.debugBody = debugString.string;
//    
//#if TRACE
////    FLTrace(@"Soap Request:"); 
//    
//    FLLogIndent(^{
//        FLLog([self.requestHeaders description]);
//        FLLog([self.requestBody description]);
//    });
//    
//    
////    , [self requestHeaders]);
////    FLTrace(@"%@", debugString.string);
//#endif    
//    
////    FLLog([self description]);
//#endif    
}

- (void) httpRequest:(FLHttpRequest*) httpRequest
throwErrorIfResponseIsError:(FLHttpResponse*) httpResponse {

// TODO: this is prone to breakage - why is this here?
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
        FLThrowError(error);
    }
}


- (void) httpRequest:(FLHttpRequest*) httpRequest
     convertResponse:(FLHttpResponse*) httpResponse
            toResult:(FLPromisedResult*) result {
    
    NSData* data = [httpResponse.responseData data];
    FLAssertNotNil(data);

#if TRACE
    FLLog(@"Soap Response:");
    FLLog([[httpResponse responseHeaders] description]);
    FLLog(FLAutorelease([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]));
#endif    

    FLParsedXmlElement* parsedSoap = [[FLSoapParser soapParser] parseData:data];
    
//    if(_handleSoapResponseBlock) {
//        return _handleSoapResponseBlock(parsedSoap);
//    }

    *result = FLRetain(parsedSoap);

//    return parsedSoap;
}

@end

@implementation FLMutableSoapHttpRequest
@synthesize input =_input;
@synthesize output = _output;
@synthesize soapAction = _soapAction;
@synthesize targetNamespace = _soapNamespace;
@synthesize operationName = _operationName;
//@synthesize handleSoapResponseBlock = _handleSoapResponseBlock;

#if FL_MRC
- (void) dealloc {
    [_handleSoapResponseBlock release];
    [_input release];
    [_output release];
    [_soapAction release];
    [_operationName release];
    [_soapNamespace release];
    [super dealloc];
}
#endif

@end



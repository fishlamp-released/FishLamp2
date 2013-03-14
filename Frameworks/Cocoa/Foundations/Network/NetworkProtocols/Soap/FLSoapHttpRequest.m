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

#if FL_MRC
- (void) dealloc {
    [_soapInput release];
    [_soapActionHeader release];
    [_operationName release];
    [_soapNamespace release];
    [_xmlDataPath release];
    [super dealloc];
}
#endif

#define MAX_ERR_LEN 500

+ (FLSoapFault11*) checkForSoapFaultInData:(NSData*) data {
	if(data && data.length >0 ) {
		char* first = strnstr((const char*) [data bytes], "Fault", MIN([data length], (unsigned int) MAX_ERR_LEN));
        if(first) {
            FLParsedXmlElement* soap = [[FLSoapParser soapParser] parseData:data];
    
            FLSoapFault11* soapFault = [[FLSoapObjectBuilder instance] buildObjectWithClass:[FLSoapFault11 class] withSoap:soap];
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

    FLParsedXmlElement* parsedSoap = [[FLSoapParser soapParser] parseData:data];
    
    if(!_xmlDataPath) {
        return parsedSoap;
    }
    
    FLParsedXmlElement* objectXml = [parsedSoap elementAtPath:_xmlDataPath];
    FLConfirmNotNil_v(objectXml, @"Element not found in result: %@", _xmlDataPath);
    
    if(!_expectedObjectClass) {
        return objectXml;
    }
    FLLog(@"object xml: %@, object type: %@", _xmlDataPath, NSStringFromClass(_expectedObjectClass));
     
    id object = [[FLSoapObjectBuilder instance] buildObjectWithClass:_expectedObjectClass withXml:objectXml];

    FLConfirmNotNil_v(object, @"object not inflated for type: %@", NSStringFromClass(_expectedObjectClass));
    FLAssertIsClass(object, _expectedObjectClass); // ([object class] == _expectedObjectClass, @"built %@, expecting %@", NSStringFromClass([object class]), NSStringFromClass(_expectedObjectClass));

    return object;
}

- (void) setExpectedResultAtXmlPath:(NSString*) path expectedObjectClass:(Class) expectedObjectClass {
    FLSetObjectWithRetain(_xmlDataPath, path);
    _expectedObjectClass = expectedObjectClass;
}

@end



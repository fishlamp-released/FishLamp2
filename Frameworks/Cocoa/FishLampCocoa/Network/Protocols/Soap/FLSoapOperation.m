//
//  FLSoapOperation.m
//  FishLampCore
//
//  Created by Mike Fullerton on 11/4/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLSoapOperation.h"
#import "FLSoapNetworkConnection.h"
#import "FLSoapParser.h"
#import "FLSoapError.h"
#import "FLSoapFault11.h"
#import "FLSoapStringBuilder.h"

@implementation FLSoapOperation 

@synthesize soapInput = _soapInput;
@synthesize soapOutput = _soapOutput;
@synthesize soapActionHeader = _soapActionHeader;
@synthesize soapNamespace = _soapNamespace;
@synthesize operationName = _operationName;
@synthesize outputName = _outputName;
@synthesize outputObject = _outputObject;

#if FL_MRC
- (void) dealloc {
    [_soapInput release];
    [_soapOutput release];
    [_outputObject release];
    [_outputName release];
    [_soapActionHeader release];
    [_operationName release];
    [_soapNamespace release];
    [super dealloc];
}
#endif

- (FLHttpConnection*) createConnection {
    return [FLHttpConnection httpConnection:
            [FLHttpRequest httpRequestWithURL:self.URL requestMethod:@"POST"]];
}

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
				release_(soapParser);
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
		release_(soapParser);
	}
}

- (void) handleSoapFault:(FLSoapFault11*) fault {
    FLThrowError_([NSError errorWithSoapFault:fault]);
}

- (FLResult) runSelf {

    FLAssertStringIsNotEmpty_(self.URL.absoluteString);
    FLAssertStringIsNotEmpty_(self.soapNamespace);
    FLAssertStringIsNotEmpty_(self.operationName);

    FLSoapStringBuilder* soap = [FLSoapStringBuilder stringBuilder];
	[soap.body addObjectAsFunction:self.operationName object:[self soapInput] xmlNamespace:self.soapNamespace];

    self.httpRequest.requestMethod = @"POST";
	[self.httpRequest setHeaderValue:self.soapActionHeader forName:@"SOAPAction"]; //[NSString stringWithFormat:@"\"%@\"", self.soapActionHeader]];
	[self.httpRequest setUtf8Content:[soap buildStringWithNoWhitespace]];

    FLHttpResponse* response = FLThrowError([super runSelf]);

    NSData* data = response.responseData;
    
    FLSoapFault11* fault = [FLSoapOperation checkForSoapFaultInData:data];
    if(fault) {
        [self handleSoapFault:fault];
    }
    
    FLThrowError_([self.httpResponse simpleHttpResponseErrorCheck]);
   
    if(_outputObject) {
        [self parseXmlResponse:data object:_outputObject];
        return _outputObject;
    }
    
    return data;
}

- (id) output {
    if(_outputName && _outputObject) {
        return [_outputObject valueForKey:_outputName];
    }
    return nil;
}

@end
@implementation FLNetworkServerContext (Soap)
- (NSString*) serverURL {
    return [self.properties objectForKey:FLNetworkServerPropertyKeyUrl];
}

- (NSString*) soapNamespace {
    return [self.properties objectForKey:FLNetworkServerPropertyKeyTargetNamespace];
}

- (NSString*) soapActionHeaderForOperationName:(NSString*) operationName {
    FLAssertStringIsNotEmpty_v(operationName, nil);
	return [self.properties objectForKey:operationName];
}
@end


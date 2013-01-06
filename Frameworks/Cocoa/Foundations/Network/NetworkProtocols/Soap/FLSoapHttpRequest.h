//
//  FLSoapHttpRequest.h
//  FLCore
//
//  Created by Mike Fullerton on 11/4/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLHttpRequest.h"
#import "FLSoapFault11.h"

typedef id (^FLSoapResponseDecoder)(id soapResponse);

@interface FLSoapHttpRequest : FLHttpRequest {
@private
// for sending request
    NSString* _soapNamespace;
    NSString* _soapActionHeader;
    NSString* _operationName;
    id _soapRequest;

// output
    id _soapResponse;
    FLSoapResponseDecoder _responseDecoder;
}

@property (readwrite, strong) id soapRequest;
@property (readwrite, strong) id soapResponse;
    
@property (readwrite, copy) FLSoapResponseDecoder responseDecoder;

@property (readwrite, strong) NSString* soapActionHeader;
@property (readwrite, strong) NSString* soapNamespace;
@property (readwrite, strong) NSString* operationName;

- (void) handleSoapFault:(FLSoapFault11*) fault;

+ (FLSoapFault11*) checkForSoapFaultInData:(NSData*) data;

@end
//
//  FLSoapHttpRequest.h
//  FLCore
//
//  Created by Mike Fullerton on 11/4/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLHttpRequest.h"
#import "FLSoapFault11.h"
#import "FLTypeDesc.h"

@interface FLSoapHttpRequest : FLHttpRequest {
@private
// for sending request
    NSString* _soapNamespace;
    NSString* _soapActionHeader;
    NSString* _operationName;
    id _soapInput;
    NSString* _xmlDataPath;
    Class _expectedObjectClass;
}

@property (readwrite, strong) id soapInput;

@property (readwrite, strong) NSString* soapActionHeader;
@property (readwrite, strong) NSString* soapNamespace;
@property (readwrite, strong) NSString* operationName;


+ (FLSoapFault11*) checkForSoapFaultInData:(NSData*) data;

- (void) setExpectedResultAtXmlPath:(NSString*) path expectedObjectClass:(Class) expectedObjectClass;

// optionally override
- (NSError*) createErrorForSoapFault:(FLSoapFault11*) fault;


@end
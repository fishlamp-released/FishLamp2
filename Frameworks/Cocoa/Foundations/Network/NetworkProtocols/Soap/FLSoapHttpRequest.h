//
//  FLSoapHttpRequest.h
//  FLCore
//
//  Created by Mike Fullerton on 11/4/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLHttpRequest.h"
#import "FLSoapFault11.h"

@interface FLSoapHttpRequest : FLHttpRequest {
@private
// for sending request
    NSString* _soapNamespace;
    NSString* _soapActionHeader;
    NSString* _operationName;
    id _soapInput;
    NSString* _xmlDataPath;
    Class _type;
}

@property (readwrite, strong) id soapInput;

@property (readwrite, strong) NSString* soapActionHeader;
@property (readwrite, strong) NSString* soapNamespace;
@property (readwrite, strong) NSString* operationName;

- (void) handleSoapFault:(FLSoapFault11*) fault;

+ (FLSoapFault11*) checkForSoapFaultInData:(NSData*) data;

- (void) setXmlPath:(NSString*) path withClassToInflate:(Class) aClass;

@end
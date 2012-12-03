//
//  FLSoapOperation.h
//  FishLampCore
//
//  Created by Mike Fullerton on 11/4/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLHttpOperation.h"
#import "FLSoapFault11.h"

@interface FLSoapOperation : FLHttpOperation {
@private
    NSString* _soapNamespace;
    NSString* _soapActionHeader;
    NSString* _outputName;
    
    NSString* _operationName;
    id _outputObject;
    
    id _soapOutput;
    id _soapInput;
}

@property (readwrite, strong) id soapInput;
@property (readwrite, strong) id soapOutput;
    
@property (readwrite, strong) NSString* outputName;
@property (readwrite, strong) id outputObject;

@property (readwrite, strong) NSString* soapActionHeader;
@property (readwrite, strong) NSString* soapNamespace;
@property (readwrite, strong) NSString* operationName;

- (void) handleSoapFault:(FLSoapFault11*) fault;

+ (FLSoapFault11*) checkForSoapFaultInData:(NSData*) data;

@end
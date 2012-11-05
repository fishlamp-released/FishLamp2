//
//  FLSoapOperation.h
//  FishLampCore
//
//  Created by Mike Fullerton on 11/4/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLHttpOperation.h"
#import "FLNetworkServerContext.h"
#import "FLSoapFault11.h"

@interface FLNetworkServerContext (Soap)
- (NSURL*) serverURL;
- (NSString*) soapNamespace;
- (NSString*) soapActionHeaderForOperationName:(NSString*) operationName;
@end


@interface FLSoapOperation : FLHttpOperation {
@private
    NSString* _operationName;
    NSString* _soapNamespace;
    NSString* _soapActionHeader;
}

@property (readwrite, strong) NSString* soapActionHeader;
@property (readwrite, strong) NSString* soapNamespace;
@property (readwrite, strong) NSString* operationName;

- (void) handleSoapFault:(FLSoapFault11*) fault;

+ (FLSoapFault11*) checkForSoapFaultInData:(NSData*) data;

@end
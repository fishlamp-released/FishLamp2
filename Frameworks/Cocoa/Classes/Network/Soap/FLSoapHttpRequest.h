//
//  FLSoapHttpRequest.h
//  FLCore
//
//  Created by Mike Fullerton on 11/4/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLHttpRequest.h"
#import "FLSoapFault11.h"
#import "FLObjectEncoder.h"
#import "FLParsedItem.h"

typedef id<FLAsyncResult> (^FLHandleSoapResponseBlock)(FLParsedItem* parsedSoap);

@interface FLSoapHttpRequest : FLHttpRequest {
@private
// for sending request
    NSString* _soapNamespace;
    NSString* _soapActionHeader;
    NSString* _operationName;
    id _soapInput;
    FLHandleSoapResponseBlock _handleSoapResponseBlock;
}

@property (readwrite, strong, nonatomic) id soapInput;

@property (readwrite, strong, nonatomic) NSString* soapActionHeader;
@property (readwrite, strong, nonatomic) NSString* soapNamespace;
@property (readwrite, strong, nonatomic) NSString* operationName;

@property (readwrite, copy, nonatomic) FLHandleSoapResponseBlock handleSoapResponseBlock;

+ (FLSoapFault11*) checkForSoapFaultInData:(NSData*) data;

// optionally override
- (NSError*) createErrorForSoapFault:(FLSoapFault11*) fault;


@end
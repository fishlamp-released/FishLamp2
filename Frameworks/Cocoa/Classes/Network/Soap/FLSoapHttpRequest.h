//
//  FLSoapHttpRequest.h
//  FLCore
//
//  Created by Mike Fullerton on 11/4/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLHttpRequest.h"
@class FLSoapFault11;
@class FLParsedXmlElement;

typedef FLPromisedResult (^FLHandleSoapResponseBlock)(FLParsedXmlElement* parsedSoap);

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
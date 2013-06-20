//
//  FLSoapHttpRequest.h
//  FLCore
//
//  Created by Mike Fullerton on 11/4/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLHttpRequestBehavior.h"
@class FLSoapFault11;
@class FLParsedXmlElement;

typedef FLPromisedResult (^FLHandleSoapResponseBlock)(FLParsedXmlElement* parsedSoap);

@interface FLSoapHttpRequest : NSObject<FLHttpRequestBehavior> {
@private
    NSURL* _url;
    NSString* _httpMethod;
}

- (id) initWithRequestURL:(NSURL*) requestURL
               httpMethod:(NSString*) httpMethod; // designated

+ (id) soapRequestWithURL:(NSURL*) url
               httpMethod:(NSString*) httpMethod;

+ (id) soapRequest;

- (NSString*) location;
- (NSString*) soapAction;
- (NSString*) targetNamespace;
- (NSString*) operationName;
- (id) input;
- (id) output;

+ (FLSoapFault11*) checkForSoapFaultInData:(NSData*) data;

// optionally override
- (NSError*) createErrorForSoapFault:(FLSoapFault11*) fault;
@end

@interface FLMutableSoapHttpRequest : FLSoapHttpRequest {
@private
// for sending request
    NSString* _targetNamespace;
    NSString* _soapAction;
    NSString* _operationName;
    id _input;
    id _ouput;
    FLHandleSoapResponseBlock _handleSoapResponseBlock;
}
@property (readwrite, strong, nonatomic) NSString* soapAction;
@property (readwrite, strong, nonatomic) NSString* targetNamespace;
@property (readwrite, strong, nonatomic) NSString* operationName;
@property (readwrite, strong, nonatomic) id input;
@property (readwrite, strong, nonatomic) id output;

@end
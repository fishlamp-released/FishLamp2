//
//  FLZenfolioSoapHttpRequest.m
//  FishLamp
//
//  Created by Mike Fullerton on 12/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZenfolioSoapHttpRequest.h"

@interface FLNetworkServerContext (Soap)
- (NSString*) serverURL;
- (NSString*) soapNamespace;
- (NSString*) soapActionHeaderForHttpRequestName:(NSString*) operationName;
@end

@implementation FLNetworkServerContext (Soap)
- (NSString*) serverURL {
    return [self.properties objectForKey:FLNetworkServerPropertyKeyUrl];
}

- (NSString*) soapNamespace {
    return [self.properties objectForKey:FLNetworkServerPropertyKeyTargetNamespace];
}

- (NSString*) soapActionHeaderForHttpRequestName:(NSString*) operationName {
    FLAssertStringIsNotEmptyWithComment(operationName, nil);
	return [self.properties objectForKey:operationName];
}
@end


@implementation FLZenfolioSoapHttpRequest

- (id) initWithGeneratedObject:(id) httpRequest serverInfo:(FLZenfolioApiSoap*) info {

    FLAssertNotNil(httpRequest);
    FLAssertNotNil(info);

    self = [super initWithRequestURL:[NSURL URLWithString:[info serverURL]]];
    if(self) {
        FLAssertNotNil(httpRequest);
        FLAssertNotNil(info);
        
        self.operationName = [httpRequest operationName];
        self.soapInput = [httpRequest input];
//        self.soapResponse = [httpRequest output];
        self.soapNamespace = [info soapNamespace];
        self.soapActionHeader = [info soapActionHeaderForHttpRequestName:self.operationName];
    }
    return self;
}

+ (id) soapHttpRequestWithGeneratedObject:(id) httpRequest  serverInfo:(FLZenfolioApiSoap*) info {
    return FLAutorelease([[[self class] alloc] initWithGeneratedObject:httpRequest serverInfo:info]);
}

- (NSError*) createErrorForSoapFault:(FLSoapFault11*) fault {
    return [NSError errorWithZenfolioSoapFault:fault];
}

@end
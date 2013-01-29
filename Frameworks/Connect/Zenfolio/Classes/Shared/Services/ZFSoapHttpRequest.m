//
//  ZFSoapHttpRequest.m
//  ZenLib
//
//  Created by Mike Fullerton on 12/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "ZFSoapHttpRequest.h"

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
    FLAssertStringIsNotEmpty_v(operationName, nil);
	return [self.properties objectForKey:operationName];
}
@end


@implementation ZFSoapHttpRequest

- (id) initWithGeneratedObject:(id) httpRequest serverInfo:(ZFApiSoap*) info {
    self = [super init];
    if(self) {
        FLAssertNotNil_(httpRequest);
        FLAssertNotNil_(info);
        
        self.operationName = [httpRequest operationName];
        self.soapRequest = [httpRequest input];
        self.soapResponse = [httpRequest output];
        self.soapNamespace = [info soapNamespace];
        self.soapActionHeader = [info soapActionHeaderForHttpRequestName:self.operationName];
        self.headers.requestURL = [NSURL URLWithString:[info serverURL]];
     }
    return self;
}

+ (id) soapHttpRequestWithGeneratedObject:(id) httpRequest  serverInfo:(ZFApiSoap*) info {
    return FLAutorelease([[[self class] alloc] initWithGeneratedObject:httpRequest serverInfo:info]);
}

- (void) handleSoapFault:(FLSoapFault11*) fault {
    FLThrowError([NSError errorWithZenfolioSoapFault:fault]);
}

@end
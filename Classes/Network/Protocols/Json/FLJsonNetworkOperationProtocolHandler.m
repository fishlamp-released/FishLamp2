//
//  FLJsonNetworkOperationBehavior.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/13/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLJsonNetworkOperationProtocolHandler.h"
#import "FLJsonRequest.h"
#import "FLJsonParser.h"

@implementation FLJsonNetworkOperationProtocolHandler

FLSynthesizeSingleton(FLJsonNetworkOperationProtocolHandler);

+ (FLJsonNetworkOperationProtocolHandler*) jsonNetworkOperationProtocolHandler {
	return FLReturnAutoreleased([[FLJsonNetworkOperationProtocolHandler alloc] init]);
}

- (void) operationDidRun:(FLHttpOperation*) operation {
    FLJsonParser* parser = [FLJsonParser jsonParser];
    operation.operationOutput = [parser parseJsonData:operation.httpResponse.responseData rootObject:operation.operationOutput];
    FLThrowIfError_(parser.error);
    FLThrowIfError_([operation.httpResponse simpleHttpResponseErrorCheck]);
}


@end


//
//  FLHttpTests.m
//  FishLampCore
//
//  Created by Mike Fullerton on 10/30/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLHttpTests.h"
#import "FLHttpRequest.h"
#import "FLDispatchQueue.h"

#import "FLHttpResponse.h"
#import "FLHttpRequestBody.h"


@interface FLTimeoutReadStreamByteReader : FLDefaultReadStreamByteReader

@end

@implementation FLTimeoutReadStreamByteReader

- (BOOL) shouldReadBytesFromStream:(FLReadStream*) stream {
    return NO;
}

@end

@implementation FLHttpTests

+ (FLUnitTestGroup*) unitTestGroup {
    return [self frameworkTestGroup];
}

- (void) testConnectionToGoogle {
    FLHttpRequest *request = [FLHttpRequest httpRequestWithURL:[NSURL URLWithString:@"http://www.google.com"] httpMethod:@"GET"];

    id result = [request runSynchronously];
    FLThrowIfError(result);

    FLHttpResponse* response = result;
    
    FLAssertNotNil(response);
    FLAssert([response isKindOfClass:[FLHttpResponse class]]);
    FLAssert(response.responseStatusCode == 200);
}

- (void) testTimeout {

    FLHttpRequest *request = [FLHttpRequest httpRequestWithURL:[NSURL URLWithString:@"http://www.google.com"] httpMethod:@"GET"];

    request.timeoutInterval = 1.0f;
    request.readStreamByteReader = FLAutorelease([[FLTimeoutReadStreamByteReader alloc] init]);

    id result = [request runSynchronously];

    FLConfirm([result isKindOfClass:[NSError class]]);
    FLConfirm([result isTimeoutError]);
}


@end

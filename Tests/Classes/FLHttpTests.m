//
//  FLHttpTests.m
//  FishLampCore
//
//  Created by Mike Fullerton on 10/30/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLHttpTests.h"
#import "FLHttpConnection.h"

@implementation FLHttpTests

- (void) testConnectionToGoogle {
    FLHttpRequest *request = [FLHttpRequest httpRequestWithURL:[NSURL URLWithString:@"http://www.google.com"]];
    FLHttpConnection* connection = [FLHttpConnection httpConnection:request];
    id result = 

    FLHttpResponse* response = FLThrowError_([connection runSynchronously]);
    FLAssertNotNil_(response);
    FLAssert_([response isKindOfClass:[FLHttpResponse class]]);
    FLAssert_(response.responseStatusCode == 200);
}

@end

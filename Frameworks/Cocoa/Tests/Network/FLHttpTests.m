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

@implementation FLHttpTests

+ (FLUnitTestGroup*) unitTestGroup {
    return [self frameworkTestGroup];
}

- (void) testConnectionToGoogle {
    FLHttpRequest *request = [FLHttpRequest httpRequest:[NSURL URLWithString:@"http://www.google.com"]];

    
    FLHttpResponse* response = [request runSynchronously];
    FLThrowIfError(response);
    
    FLAssertNotNil(response);
    FLAssert([response isKindOfClass:[FLHttpResponse class]]);
    FLAssert(response.responseStatusCode == 200);
}

@end
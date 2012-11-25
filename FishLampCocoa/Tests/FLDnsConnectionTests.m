//
//  FLDnsConnectionTests.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/4/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLDnsConnectionTests.h"
#import "FLNetworkHost.h"
#import "FLNetworkHostResolver.h"
#import "FLDispatchQueue.h"

@implementation FLDnsConnectionTests

- (void) testCreateHostByName {

    FLNetworkHost* host = [FLNetworkHost networkHostWithName:@"google.com"];
    
    FLAssertIsFalse_(host.isResolved);
    FLAssertObjectsAreEqual_(host.hostName, @"google.com");
    
    FLLog(host.hostName);
}


- (void) testFailureOnBadInput {

//    [self runTestWithExpectedFailure:^{
//        FLNetworkHost* host = [FLNetworkHost networkHostWithName:nil];
//        FLAssertIsNil_(host);
//        }];
}

- (void) testResolve {

    FLNetworkHost* host = [FLNetworkHost networkHostWithName:@"google.com"];
    
    FLNetworkHostResolver* resolver = [FLNetworkHostResolver networkHostResolver:host];
    FLFinisher* finisher = [resolver openConnection:FLFifoQueue];
    [finisher waitUntilFinished];
    
    FLThrowError_(finisher.result);
    
    FLAssertIsTrue_(host.isResolved);
    
    NSArray* resolvedAddressStrings = [host resolvedAddressStrings];
    for(NSString* string in resolvedAddressStrings) {
        FLLog(string);
    }
}
@end

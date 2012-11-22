//
//  FLUnretainedUnitTests.m
//  Downloader
//
//  Created by Mike Fullerton on 11/20/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLUnretainedUnitTests.h"
#import "FLUnretained.h"

@implementation FLUnretainedUnitTests

- (void) testMethodForwarding {

    NSString* str = @"hello world";
    
    id unretained = [str unretained];
    
    FLAssertIsNotNil_(unretained);

    FLAssert_([unretained rangeOfString:@"hello"].location == 0);

    FLTestLog(@"Testing 123: %@", [unretained description]);
    
    NSString* newString = [NSString stringWithString:unretained];
    
    FLAssertObjectsAreEqual_(newString, str);
    
    FLTestLog(@"Testing 345: %@", newString);
}

- (void) testDeletion_off {
    
//    NSString* str = [[NSString alloc] initWithFormat:@"hello %@", @"world"];
//    
//    id unretained = [str unretained];
//    FLReleaseWithNil_(str);
//    
//    FLAsyncRunner* runner = [FLAsyncRunner asyncRunner];
//    [runner waitForCondition:^(BOOL* metCondition){
//        *metCondition = ([unretained object] == nil);
//    }];
//
//    FLAssert_(runner.isFinished);
//    FLAssertIsNil_([unretained object]);
    
}
@end
//
//  FLUnretainedUnitTests.m
//  FishLamp
//
//  Created by Mike Fullerton on 11/20/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLUnretainedUnitTests.h"
#import "FLUnretained.h"

@implementation FLUnretainedUnitTests

- (void) testMethodForwarding {

    NSString* str = @"hello world";
    
    id unretained = [str unretained];
    
    FLAssertIsNotNil(unretained);

    FLAssert([unretained rangeOfString:@"hello"].location == 0);

    FLTestLog(@"Testing 123: %@", [unretained description]);
    
    NSString* newString = [NSString stringWithString:unretained];
    
    FLAssertObjectsAreEqual(newString, str);
    
    FLTestLog(@"Testing 345: %@", newString);
}

- (void) testDeletion_off {
    
//    NSString* str = [[NSString alloc] initWithFormat:@"hello %@", @"world"];
//    
//    id unretained = [str unretained];
//    FLReleaseWithNil(str);
//    
//    FLAsyncRunner* runner = [FLAsyncRunner asyncRunner];
//    [runner waitForCondition:^(BOOL* metCondition){
//        *metCondition = ([unretained object] == nil);
//    }];
//
//    FLAssert(runner.isFinished);
//    FLAssertIsNil([unretained object]);
    
}

+ (FLUnitTestGroup*) unitTestGroup {
    return [self sanityCheckTestGroup];
}
@end
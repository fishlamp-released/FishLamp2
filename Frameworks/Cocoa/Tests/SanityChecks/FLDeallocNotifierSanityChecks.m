//
//  FLDeallocNotifierSanityChecks.m
//  FishLampCoreTests
//
//  Created by Mike Fullerton on 11/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//
#if REFACTOR

#import "FLDeallocNotifierSanityChecks.h"
#import "FLDispatchQueue.h"
#import "FLCallback.h"
#import "FLTimeoutTests.h"

@interface FLDeleteNotifier : FLCallback {
}
@end

@implementation FLDeleteNotifier
- (void) dealloc {
    [self invoke:nil];
#if FL_MRC
    [self sendDeallocNotification];
    [super dealloc];
#endif
}
@end



@implementation FLDeallocNotifierSanityCheck


//- (void) testAssociatedObjectsDelete {
//    s_deleted = NO;
//    NSMutableString* str = [[NSMutableString alloc] initWithString:@"hello world"];
//    [str setTestThingy:[FLDeleteObjectThingy new]];
//    str = nil;
//    FLAssert(s_deleted == YES);
//}

//- (void) didDelete:(id) sender {
//    [self.finisher setFinished];
//    self.finisher = nil;
//}

+ (FLUnitTestGroup*) unitTestGroup {
    return [self frameworkTestGroup];
}

+ (NSArray*) unitTestDependencies {
    return [NSArray arrayWithObject:[FLTimeoutTests class]];
}

- (void) testLazyCreate {
//    NSMutableString* str = [NSMutableString string];
//    FLAssertIsNil([str _deallocNotifier]);
//    id notifier = [str deallocNotifier];
//    FLAssertIsNotNil(notifier);
//    FLAssert(notifier == [str _deallocNotifier]);
//    FLAssert(notifier == [str deallocNotifier]);
}

- (void) testDeleteNotification {

    __block BOOL objectDeleted = NO;
    __block BOOL notified = NO;

#if FL_ARC
    __block __weak id test = nil;
#endif    
    
    FLAsyncTaskBlock asyncBlock = ^(FLFinisher* asyncFinisher) {

        FLDeleteNotifier* notifier = [[FLDeleteNotifier alloc] initWithBlock:^(id sender){
            objectDeleted = YES;
        }];
        
        [notifier addDeallocNotifierWithBlock:^(FLDeletedObjectReference* ref){
            notified = YES;
            [asyncFinisher setFinished];
        }];

        FLManuallyRelease(&notifier);
        FLAssertIsNil(notifier);
          
#if FL_ARC
        FLAssertIsNil(test);
#endif        
    };
    
    
    FLFinisher* finisher = [FLDefaultQueue dispatchAsyncBlock:asyncBlock];
        
#if FL_ARC
    FLAssertIsNil(test);
#endif    
    
    [finisher waitUntilFinished];
    id result = finisher.result;
    FLAssertNotNil(result);
    
    FLAssertIsTrue(objectDeleted);
    FLAssertIsTrue(notified);
}

//- (void) testNotify:(FLFinisher*) finisher {
//
//    NSMutableString* str = [[NSMutableString alloc] initWithString:@"hello world"];
//    
//    [str addDeallocListener:self action:@selector(didDelete:)];
//    FLReleaseWithNil(str);
//
//    self.finisher = finisher;
//}





@end



#endif
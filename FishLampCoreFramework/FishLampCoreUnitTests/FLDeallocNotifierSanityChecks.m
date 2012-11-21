//
//  FLDeallocNotifierSanityChecks.m
//  FishLampCoreTests
//
//  Created by Mike Fullerton on 11/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLDeallocNotifierSanityChecks.h"
#import "FLDispatchQueues.h"
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
//    FLAssert_(s_deleted == YES);
//}

//- (void) didDelete:(id) sender {
//    [self.finisher setFinished];
//    self.finisher = nil;
//}

+ (NSArray*) unitTestDependencies {
    return [NSArray arrayWithObject:[FLTimeoutTests class]];
}

- (void) testLazyCreate {
//    NSMutableString* str = [NSMutableString string];
//    FLAssertIsNil_([str _deallocNotifier]);
//    id notifier = [str deallocNotifier];
//    FLAssertIsNotNil_(notifier);
//    FLAssert_(notifier == [str _deallocNotifier]);
//    FLAssert_(notifier == [str deallocNotifier]);
}

- (void) testDeleteNotification {

    __block BOOL objectDeleted = NO;
    __block BOOL notified = NO;

#if FL_ARC
    __block __weak id test = nil;
#endif    

    FLFinisher* finisher = [FLFinisher finisher];
    
    FLAsyncTaskBlock asyncBlock = ^(FLFinisher* asyncFinisher) {

        FLAssert_(finisher == asyncFinisher);
    
        FLDeleteNotifier* notifier = [[FLDeleteNotifier alloc] initWithBlock:^(id sender){
            objectDeleted = YES;
        }];
        
        [notifier addDeallocNotifierWithBlock:^(FLDeletedObjectReference* ref){
            notified = YES;
            [asyncFinisher setFinished];
        }];

        FLManuallyRelease(&notifier);
        FLAssertIsNil_(notifier);
          
#if FL_ARC
        FLAssertIsNil_(test);
#endif        
    };
    
    
    FLFinisher* returnedFinisher = [FLDispatchQueue dispatch:asyncBlock finisher:finisher];
    
    FLAssert_(finisher == returnedFinisher);
    
#if FL_ARC
    FLAssertIsNil_(test);
#endif    
    
    [finisher waitUntilFinished];
    id result = finisher.result;
    FLAssertNotNil_(result);
    
    FLAssertIsTrue_(objectDeleted);
    FLAssertIsTrue_(notified);
}

//- (void) testNotify:(FLFinisher*) finisher {
//
//    NSMutableString* str = [[NSMutableString alloc] initWithString:@"hello world"];
//    
//    [str addDeallocListener:self action:@selector(didDelete:)];
//    FLReleaseWithNil_(str);
//
//    self.finisher = finisher;
//}





@end




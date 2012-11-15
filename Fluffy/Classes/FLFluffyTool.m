//
//  FLFluffyTool.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/22/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLFluffyTool.h"

#import "FLJob.h"
#import "FLRunUnitTestsOperation.h"
#import "FLObjcRuntime.h"
#import "FLDispatchQueues.h"

#import "FLUsageTask.h"

@interface FLFluffyTool ()
@end

@implementation FLFluffyTool

- (id) init {
    self = [super initWithCommandLineParser:[FLCommandLineParser create]];
    if(self) {
        [self addTask:[FLUsageTask toolTask]];
    
    
//        [self addInputHandler:[FLArgumentHandler argumentHandler:@"-b,--bundle,"
//                                            inputFlags:FLArgumentIsExpectingData | FLArgumentItemMustAlreadyExist
//                                           description:@"loads test bundle"
//                                              selector:@selector(runTestsInBundle:)]];

    }
    return self;
}

//- (void) runTestsInBundle:(FLArgumentHandler*) handler {
//
//}

- (NSString*) toolName {
    return @"Fluffy";
}

- (void) runToolTask {
    NSLog(@"Fluffy is starting.")
    
//    [[FLRunUnitTestsOperation create] runSynchronously];
    
    NSLog(@"Fluffy is done.");
    
//    FLSanityCheckRunner* runner = [FLSanityCheckRunner new];
//    FLWorkFinisher* finisher2 = [runner startTests:^{
//        NSLog(@"done with critical tests");
//    }];
//
//    [finisher2 waitForResult];
//    release_(runner);
//

//
//    FLForegroundJob* fgBot = [FLForegroundJob job];
//    [fgBot addWorker:[FLRunUnitTestsOperation unitTestRunner]];
//    [[fgBot runBot:nil] waitForResult];
}

//- (void) addInputHandlers {
//
//    [self addInputHandler:FLReturnObject(^{
//        FLInputHandler* argumentHandler = [FLInputHandler argumentHandler];
//        [argumentHandler addInputParameter:@"-i"];
//        [argumentHandler addInputParameter:@"--input"];
//        [argumentHandler addCompatibleParameter:@"-r"];
//        [argumentHandler addCompatibleParameter:@"-g"];
//        [argumentHandler addCompatibleParameter:@"-o"];
//
//        argumentHandler.expectsData = YES;
//        argumentHandler.helpDescription = @"Path to a directory or a file to whittle. Whittle will find all Whittle files in a dir.";
//        argumentHandler.executeCallback = ^(FLInputHandler* handler, id data) {
//            if(!FLStringsAreEqual(data, @".")) {    
//                FLRetainObject_(_optionalPath, data);
//            }
//        };        
//        return argumentHandler;
//    })];
//
//}
//
//- (void) runToolTask {
//
////    FLUnitTestObserver* myObserver = [FLUnitTestObserver unitTestObserver];
////
////    myObserver.discovered = ^(NSUInteger testCount, NSUInteger methodCount) {
////        FLPrintf(@"%d tests, %d methods\n", testCount, methodCount);
////    };
////
////    myObserver.willFilter = ^(NSString* testName, NSString* methodName, BOOL* shouldRunTest) {
////    };
////    
////    myObserver.willAllow = ^(FLUnitTest* test, BOOL* shouldRun) {
////    };
////    
////    myObserver.observeStart = ^(FLUnitTest* test, NSString* name) {
//////        FLPrintf(@"%@: starting\n", [test testNameWithMethod:name]);
////    };
////    
////    myObserver.observeFinish = ^(FLUnitTest* test, NSString* name, BOOL passed, NSString* failString) {
////        if(passed) {
//////            FLPrintf(@"%@: passed\n", [test testNameWithMethod:name]);
////        }
////        else {
//////            FLPrintf(@"%@: FAILED (%@)\n", [test testNameWithMethod:name], failString);
////        }
////    };
////    
////    myObserver.observeResult = ^(FLUnitTest* test, NSUInteger methodRunCount, NSUInteger methodFailCount) {
////    
////    };
////
////    myObserver.observeAllResults = ^(NSUInteger methodRunCount, NSUInteger methodFailCount) {
////        FLPrintf(@"%d passed, %d failed\n", methodRunCount, methodFailCount);
////    };
//
//   
//      [[FLForegroundJob runBot:[FLRunUnitTestsOperation unitTestRunner]] waitUntiFinished];
//    
////    if(![runner runAllTests]) {
////        NSLog(@"Tests failed");
////    }
//}

//}
@end

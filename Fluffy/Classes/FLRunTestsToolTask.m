//
//  FLRunTestsToolTask.m
//  Fluffy
//
//  Created by Mike Fullerton on 11/15/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

//#import "FLRunTestsToolTask.h"
//#import "FLUnitTestRunner.h"

//@implementation FLRunTestsToolTask
//
//- (NSArray*) parameterKeys {
//    return [NSArray arrayWithObjects:@"-b", @"--bundle", nil];
//}
//
//- (void) startWorking:(id) asyncTask {
//
//    FLCommandLineArgument* arg = [asyncTask commandLineArgument];
//    
//    for(NSString* path in arg.values) {
//        NSBundle *bundle = [NSBundle bundleWithPath:path];
//        [bundle load];
//    }
//    
//    [[FLUnitTestRunner unitTestRunner] runSynchronouslyWithAsyncTask:asyncTask];
//}
//
//@end

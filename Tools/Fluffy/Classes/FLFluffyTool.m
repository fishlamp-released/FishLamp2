//
//  FLFluffyTool.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/22/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLFluffyTool.h"
#import "FLUsageTask.h"
#import "FLRunTestsToolTask.h"

#import "FLShellCommand.h"

@interface FLTestShellCommand : FLToolTask
@end

@implementation FLTestShellCommand 

- (NSArray*) argumentKeys {
    return [NSArray arrayWithObjects:@"-ls", nil];
}

- (void) runWithArgument:(FLCommandLineArgument*) argument inTool:(FLTool*) tool {
    FLShellCommand* command = [FLShellCommand shellCommand:@"/bin/date"];
    [command runSynchronously];
    
    NSString* result = command.output;
    FLLog(@"date: %@", result)
}

@end

@interface FLRunTestApp : FLToolTask
@end

@implementation FLRunTestApp 

- (NSArray*) argumentKeys {
    return [NSArray arrayWithObjects:@"-t", @"--target", nil];
}

- (void) runWithArgument:(FLCommandLineArgument*) argument inTool:(FLTool*) tool {

    FLShellCommand* command = [FLShellCommand shellCommand:[argument.values objectAtIndex:0]];
    [command runSynchronously];
    
    NSString* result = command.output;
    FLLog(@"unit test result: %@", result)
}

@end




@implementation FLFluffyTool

- (id<FLCommandLineParser>) toolWillRun:(FLTool*) tool {
    tool.toolName = @"Fluffy";
    [tool setDefaultToolTask:[FLUsageTask toolTask]];
    [tool addToolTask:[FLTestShellCommand toolTask]];
    [tool addToolTask:[FLRunTestApp toolTask]];
    return [FLCommandLineParser commandLineParser];
}

- (void) tool:(FLTool*) tool willRunWithArguments:(NSArray*) commandLineArgumentArray {
}

@end

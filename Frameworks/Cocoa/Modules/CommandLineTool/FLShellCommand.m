//
//  FLShellCommand.m
//  FishLampOSXTool
//
//  Created by Mike Fullerton on 5/27/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLShellCommand.h"
#if OSX
@implementation FLShellCommand

- (id) initWithLaunchPath:(NSString*) path {
    self = [super init];
    if(self) {
        _launchPath = [path copy];
        _args = [[NSMutableArray alloc] init];
    }
    return self;
}

+ (id) shellCommand:(NSString*) launchPath {
    return FLAutorelease([[[self class] alloc] initWithLaunchPath:launchPath]);
}

#if FL_MRC
- (void) dealloc {
    [_args release];
    [_launchPath release];
    [super dealloc];
}
#endif

- (void) addArgument:(FLCommandLineArgument*) arg {
    [_args addObject:arg];
}

//- (void)launch {
//    NSTask *task = [[[NSTask alloc] init] autorelease];
//    [task setLaunchPath:@"/path/to/command"];
//    [task setArguments:[NSArray arrayWithObjects:..., nil]];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(readCompleted:) name:NSFileHandleReadToEndOfFileCompletionNotification object:[outputPipe fileHandleForReading]];
//    [[outputPipe fileHandleForReading] readToEndOfFileInBackgroundAndNotify];
//    [task launch];
//}
//
//- (void)readCompleted:(NSNotification *)notification {
//    NSLog(@"Read data: %@", [[notification userInfo] objectForKey:NSFileHandleNotificationDataItem]);
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSFileHandleReadToEndOfFileCompletionNotification object:[notification object]];
//}
//
- (FLResult) runOperationInContext:(id) context withObserver:(id) observer {

    NSTask* task = [[NSTask alloc] init];
    @try {
        NSMutableArray* args = [NSMutableArray array];
        
        for(FLCommandLineArgument* arg in _args) {
            [args addObject:[arg parameterString]];
        }

        [task setLaunchPath:_launchPath];
        
        if(args && args.count) {
            [task setArguments:args];
        }

        __block BOOL taskTerminated = NO;
    
        task.terminationHandler = ^(NSTask* aTask) {
            taskTerminated = YES;
        };

        NSPipe *outputPipe = [NSPipe pipe];
        [task setStandardOutput:outputPipe];
    
        [task launch];
            
        while(task.isRunning && !taskTerminated) {

// TODO: cancel support?? do we need an error?

//            if(self.error) {
//                [task terminate];
//            }
        }
        
        NSString* outputStr = nil;
        NSFileHandle* file = nil;
        
        id output = [task standardOutput];
        if ( [output isKindOfClass:[NSPipe class]]) {
            file = [output fileHandleForReading];
        }
        else if( [output isKindOfClass:[NSFileHandle class]]){
            file = output;
        }

        if(file) {
            NSData* data = [file availableData];
            outputStr = FLAutorelease([[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding]);
        }
        
        return outputStr;
    }
    @catch (NSException* ex) {
        FLLog(@"Exception: %@", [ex description]);
        FLAssert_v(!task.isRunning, @"task is still running but we got an exception: %@", [ex description])
        @throw;
    }
    @finally {
        task.terminationHandler = nil;
        FLRelease(task);
    }
    
    return FLFailedResult;
}
@end

#endif
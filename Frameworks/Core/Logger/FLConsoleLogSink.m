//
//  FLConsoleLogSink.m
//  FLCore
//
//  Created by Mike Fullerton on 11/1/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLConsoleLogSink.h"
#import "FLPrintf.h"

@implementation FLConsoleLogSink

+ (id) consoleLogSink {
    return FLAutorelease([[[self class] alloc] init]);
}

+ (FLLogSink*) consoleLogSink:(FLLogSinkOutputFlags) outputFlags {
    return FLAutorelease([[[self class] alloc] initWithOutputFlags:outputFlags]);
}


- (id) init {
    self = [super init];
    if(self) {
    }
    return self;
}


- (void) logEntry:(FLLogEntry*) entry
             stop:(BOOL*) stop {

// TODO: make a lookup table, this sucks.    
//    char spaces[128];
//    char* sptr = spaces;
//    for(int i = 0; i < entry.logName.length + 3; i++) {
//        *sptr++ = ' ';
//    }
//    *sptr = 0;

    NSString* logString = nil;
    
    if(entry.error) {
        logString = [NSString stringWithFormat:@"error: %@ %@", entry.error.localizedDescription, entry.error.comment];
    }
    else if(entry.exception) {
        logString = [NSString stringWithFormat:@"exception: %@ name: reason: %@", 
            entry.exception.name, 
            entry.exception.reason];
    }
    else {
        logString = entry.logString;
    }

    
    if(FLTestAnyBit(self.outputFlags, FLLogOutputWithLocation | FLLogOutputWithStackTrace)) {
        FLPrintf(@"%@ (%s:%d)\n", 
                      logString,
                      entry.stackTrace.fileName, 
                      entry.stackTrace.lineNumber
//                          entry.stackTrace.function,
                      );
    }
    else {
        FLPrintf(entry.logString);
    }

    if(FLTestBits(self.outputFlags, FLLogOutputWithStackTrace)) {
        if(entry.stackTrace.callStack.depth) {
            for(int i = 0; i < entry.stackTrace.callStack.depth; i++) {
                FLPrintf(@"%s%s\n", "   ", [entry.stackTrace stackEntryAtIndex:i]);
            }
        }
    }
    
}    

@end

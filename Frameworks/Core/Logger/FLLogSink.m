//
//  FLLogSink.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/22/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLLogSink.h"
#import "FLPrettyString.h"

@implementation FLLogSink

- (id) initWithLogSinkOutputFlags:(FLLogSinkOutputFlags) outputFlags  {

    self = [super init];
    if(self) {
        _outputFlags = outputFlags;
    }
    
    return self;
}

+ (FLLogSink*) logSink:(FLLogSinkOutputFlags) outputFlags {
    return FLAutorelease([[[self class] alloc] initWithLogSinkOutputFlags:outputFlags]);
}


- (void) openEntry {
}

- (void) appendLine:(NSString*) line {
}

- (void) closeEntry {
}

- (void) appendLogEntry:(FLLogEntry*) entry
                   stop:(BOOL*) stop {
    
    [self openEntry];

// TODO: make a lookup table, this sucks.    
//    char spaces[128];
//    char* sptr = spaces;
//    for(int i = 0; i < entry.logName.length + 3; i++) {
//        *sptr++ = ' ';
//    }
//    *sptr = 0;
    
    if(FLTestAnyBit(_outputFlags, FLLogOutputWithLocation | FLLogOutputWithStackTrace)) {
        [self appendLine:[NSString stringWithFormat:@"%@ (%s:%d)", 
                          entry.logString,
                          entry.stackTrace.fileName, 
                          entry.stackTrace.lineNumber
//                          entry.stackTrace.function,
                          ]];
    }
    else {
         [self appendLine:entry.logString];
    }

    if(FLTestBits(_outputFlags, FLLogOutputWithStackTrace)) {
        if(entry.stackTrace.callStack.depth) {
            for(int i = 0; i < entry.stackTrace.callStack.depth; i++) {
                [self appendLine:[NSString stringWithFormat:@"%s%s", "   ", [entry.stackTrace stackEntryAtIndex:i]]];
            }
        }
    }
    
    [self closeEntry];
}

@end





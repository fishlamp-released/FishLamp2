//
//  FLUnitTestLoggable.m
//  Fishlamp
//
//  Created by Mike Fullerton on 6/19/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLUnitTestLogger.h"
#import "_FLUnitTestLogger.h"
#import "_FLUnitTestManager.h"

@implementation FLUnitTestLogger

@synthesize unitTestManager = _manager;

- (void) _logString:(NSString*) string {
    if([NSThread mainThread] == [NSThread currentThread]){
        [_manager logString:string];
    }
    else {
        [self performSelectorOnMainThread:@selector(_logString:) withObject:string waitUntilDone:YES];
    }
}

- (void) log:(NSString*) format, ... {
    if(format) {
        va_list va;
        va_start(va, format);
        NSString* string = FLReturnAutoreleased([[NSMutableString alloc] initWithFormat:format arguments:va]);
        va_end(va);

        [self _logString:string];
    }
}


@end

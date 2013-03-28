//
//  FLLogger.m
//  FLCore
//
//  Created by Mike Fullerton on 11/1/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLLogger.h"
#import <objc/runtime.h>
@implementation FLLogger

- (id) initWithWhitespace:(FLWhitespace*) whitespace {
    self = [super init];
    if(self) {
        static int count = 0;
        char buffer[128];
        snprintf(buffer, 128, "com.fishlamp.logger%d", count++);
        _fifoQueue = dispatch_queue_create(buffer, DISPATCH_QUEUE_SERIAL);
        _sinks = [[NSMutableArray alloc] init];
        _whitespace = FLRetain(whitespace);
        _eolString = FLRetain(_whitespace ? _whitespace.eolString : @"");
    }
    
    return self;
}

+ (id) loggerWithWhitespace:(FLWhitespace*) whitespace {
    return FLAutorelease([[[self class] alloc] initWithWhitespace:whitespace]);
}

+ (id) logger {
    return FLAutorelease([[[self class] alloc] init]);
}

- (id) init {
    return [self initWithWhitespace:[FLWhitespace tabbedWithSpacesWhitespace]];
}   

- (void) dealloc {
    dispatch_release(_fifoQueue);
#if FL_MRC
    [_eolString release];
    [_whitespace release];
    [_sinks release];
    [super dealloc];
#endif
}

- (void) logger:(FLLogger*) logger dispatchBlock:(dispatch_block_t) block {
    dispatch_async(_fifoQueue, block); 
}

- (void) dispatchBlock:(dispatch_block_t) block {
    dispatch_sync(_fifoQueue, block); 
}

- (void) pushLoggerSink:(id<FLLogSink>) sink {
    [self dispatchBlock: ^{
        [_sinks insertObject:sink atIndex:0];
    }];
}

- (void) addLoggerSink:(id<FLLogSink>) sink {
    [self dispatchBlock: ^{
        [_sinks addObject:sink];
    }];
}

- (void) removeLoggerSink:(id<FLLogSink>) sink {
    [self dispatchBlock: ^{
        [_sinks removeObject:sink];
    }];
}

- (void) sendEntryToSinks:(FLLogEntry*) entry {
    BOOL stop = NO;
    for(id<FLLogSink> sink in _sinks) {
        [sink logEntry:entry stop:&stop];
        if(stop) {
            break;
        }
    } 
    [entry releaseToCache];
}

- (void) logEntry:(FLLogEntry*) entry {
    [self dispatchBlock: ^{
        [self sendEntryToSinks:entry];
    }];
}

- (void) logEntries:(NSArray*) entryArray {
    [self dispatchBlock: ^{
        for(FLLogEntry* entry in entryArray) {
            [self sendEntryToSinks:entry];
        }
    }];
}


- (void) logString:(NSString*) string
           logType:(NSString*) logType
        stackTrace:(FLStackTrace*) stackTrace {
 

    if(FLStringIsEmpty(string)) {
        return;
    }

#if DEBUG
    NSCAssert(![string isEqualToString:@"(null)"], @"got null string in logger");
    NSCAssert(string != nil, @"logger line is nil");
#endif

    [self dispatchBlock: ^{
        FLLogEntry* entry = [FLLogEntry logEntry];
        entry.logString = string;
        entry.logType = logType;
        entry.stackTrace = stackTrace;
        [self sendEntryToSinks:entry];
    }];
}

- (void) logError:(NSError*) error {
    [self dispatchBlock: ^{
        FLLogEntry* entry = [FLLogEntry logEntry];
        entry.error = error;
        entry.logString = [error localizedDescription];
        entry.stackTrace = error.stackTrace;
        [self sendEntryToSinks:entry];
    }];
}

- (void) logException:(NSException*) exception withComment:(NSString*) comment {
    FLLogEntry* entry = [FLLogEntry logEntry];
    entry.exception = exception;
    
    NSString* info = [NSString stringWithFormat:@"name: %@, reason: %@", exception.name, exception.reason];
    
    if(comment) {
        comment = [NSString stringWithFormat:@"%@ (%@)", comment, info];
    }
    else {
        comment = info;
    }
    
    entry.logString = comment;
    entry.stackTrace = [FLStackTrace stackTraceWithException:exception];

    [self sendEntryToSinks:entry];
}

- (void) logException:(NSException*) exception {
    [self dispatchBlock: ^{
        [self logException:exception withComment:nil];
    }];
}


//- (void) logString:(NSString*) string;
//- (void) logFormat:(NSString*) format, ...;
//- (void) logFormat:(NSString*) format arguments:(va_list) list;

- (void) logString:(NSString*) string {
    [self logString:string logType:FLLogTypeLog stackTrace:nil];
}

//
//- (void) logFormat:(NSString*) format, ... {
//    FLAssertNotNil(format);
//	va_list va;
//	va_start(va, format);
//	NSString *string = FLAutorelease([[NSString alloc] initWithFormat:format arguments:va]);
//	va_end(va);
//    [self logString:string logType:FLLogTypeLog stackTrace:nil];
//}
//
//- (void) logFormat:(NSString*) format arguments:(va_list) va_list {
//	NSString *string = FLAutorelease([[NSString alloc] initWithFormat:format arguments:va_list]);
//    [self logString:string logType:FLLogTypeLog stackTrace:nil];
//}


- (void) stringFormatter:(FLStringFormatter*) stringFormatter 
            appendString:(NSString*) string
  appendAttributedString:(NSAttributedString*) attributedString
              lineUpdate:(FLStringFormatterLineUpdate) lineUpdate {


    if(lineUpdate.closePreviousLine) {
        [self logString:@"\n"];
    }

    if(lineUpdate.prependBlankLine) {
        [self logString:@"\n"];
    }

    if(lineUpdate.openLine) {
//        if(_whitespace) { 
//            [self appendStringToStorage:[_whitespace tabStringForScope:self.indentLevel]];
//        } 
    }
    
    if(string) {
        [self logString:string];
    }
    
    if(attributedString) {
        [self logString:[attributedString string]];
    }
    
    if(lineUpdate.closeLine) {
        [self logString:@"\n"];
    }
}            

- (void) indent {
}

- (void) outdent {
}


@end

@implementation NSException (FLLogger)
- (void) logExceptionToLogger:(FLLogger*) logger {
    [logger logException:self];
}
@end


@implementation FLErrorException (FLLogger)

- (void) logExceptionToLogger:(FLLogger*) logger {
    
    NSError* error = self.error;
    if(error) {
        [logger logError:error];
    }
    else {
        [super logExceptionToLogger:logger]; // really [super raiseAndLog]
    }
}

@end

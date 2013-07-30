//
//  FLLogger.m
//  FLCore
//
//  Created by Mike Fullerton on 11/1/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLLogger.h"
#import "FishLampCore.h"
#import <objc/runtime.h>

@interface FLLogger()
@property (readwrite, strong, nonatomic) NSMutableString* line;
@property (readonly, strong, nonatomic) NSMutableArray* sinks;
@property (readwrite, assign, nonatomic) NSInteger indentLevel;
@end

@implementation FLLogger

@synthesize line = _line;
@synthesize sinks = _sinks;
@synthesize indentLevel = _indentLevel;

- (id) init {
    self = [super init];
    if(self) {
        static int count = 0;
        char buffer[128];
        snprintf(buffer, 128, "com.fishlamp.logger%d", count++);
#if __MAC_10_8
        _fifoQueue = dispatch_queue_create(buffer, DISPATCH_QUEUE_SERIAL);
#else 
        _fifoQueue = dispatch_queue_create(buffer, nil);

#endif        
        _sinks = [[NSMutableArray alloc] init];
        self.stringFormatterOutput = self;
    }
    
    return self;
}


+ (id) logger {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) dealloc {
    dispatch_release(_fifoQueue);
#if FL_MRC
    [_line release];
    [_sinks release];
    [super dealloc];
#endif
}

//- (void) logger:(FLLogger*) logger dispatchBlock:(dispatch_block_t) block {
//    dispatch_async(_fifoQueue, block); 
//}

- (void) dispatchBlock:(FLLoggerBlock) block {

    FLPrepareBlockForFutureUse(block);

    __unsafe_unretained FLLogger* logger = self;
    dispatch_sync(_fifoQueue, ^{
        block(logger);
    });
}

- (void) pushLoggerSink:(id<FLLogSink>) sink {
    [self dispatchBlock: ^(FLLogger* logger) {
        [logger.sinks insertObject:sink atIndex:0];
    }];
}

- (void) addLoggerSink:(id<FLLogSink>) sink {
    [self dispatchBlock: ^(FLLogger* logger){
        [logger.sinks addObject:sink];
    }];
}

- (void) removeLoggerSink:(id<FLLogSink>) sink {
    [self dispatchBlock: ^(FLLogger* logger){
        [logger.sinks removeObject:sink];
    }];
}

- (void) sendEntryToSinks:(FLLogEntry*) entry {
    BOOL stop = NO;
    entry.indentLevel = _indentLevel;
    for(id<FLLogSink> sink in _sinks) {
        [sink logEntry:entry stopPropagating:&stop];
        if(stop) {
            break;
        }
    } 
    [entry releaseToCache];
    _length ++ ;
}

- (void) logEntry:(FLLogEntry*) entry {
    [self dispatchBlock: ^(FLLogger* logger){
        [logger sendEntryToSinks:entry];
    }];
}

- (void) logEntries:(NSArray*) entryArray {

    [self dispatchBlock: ^(FLLogger* logger){
        for(FLLogEntry* entry in entryArray) {
            [logger sendEntryToSinks:entry];
        }
    }];
}

- (void) closeCurrentLine {
    if(self.line) {
        FLLogEntry* entry = [FLLogEntry logEntry];
        entry.logString = self.line;
        entry.logType = FLLogTypeLog;
        entry.indentLevel = _indentLevel;
        [self sendEntryToSinks:entry];
        self.line = nil;
    }
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

    [self dispatchBlock: ^(FLLogger* logger){

        [logger closeCurrentLine];
    
        FLLogEntry* entry = [FLLogEntry logEntry];
        entry.indentLevel = _indentLevel;
        entry.logString = string;
        entry.logType = logType;
        entry.stackTrace = stackTrace;
        [logger sendEntryToSinks:entry];
    }];
}

- (void) stringFormatterAppendBlankLine:(FLStringFormatter*) stringFormatter {
    [self dispatchBlock: ^(FLLogger* logger){
        FLLogEntry* entry = [FLLogEntry logEntry];
        entry.logString = @"";
        entry.logType = FLLogTypeLog;
        entry.indentLevel = _indentLevel;
        [logger sendEntryToSinks:entry];
    }];
}

- (void) stringFormatterOpenLine:(FLStringFormatter*) stringFormatter {
}

- (void) stringFormatterCloseLine:(FLStringFormatter*) stringFormatter {
    [self dispatchBlock: ^(FLLogger* logger){
        [logger closeCurrentLine];
    }];
}

- (void) stringFormatter:(FLStringFormatter*) stringFormatter appendString:(NSString*) string {
    [self dispatchBlock: ^(FLLogger* logger){
        if(logger.line) {
            [logger.line appendString:string];
        }
        else {
            logger.line = FLMutableCopyWithAutorelease(string);
        }
    }];
}

- (void) stringFormatter:(FLStringFormatter*) stringFormatter appendAttributedString:(NSAttributedString*) attributedString {
    [self stringFormatter:stringFormatter appendString:attributedString.string];
}

- (void) stringFormatter:(FLStringFormatter*) stringFormatter
appendSelfToStringFormatter:(id<FLStringFormatter>) anotherStringFormatter {

}


- (void) stringFormatterIndent:(FLStringFormatter*) stringFormatter {
    [self dispatchBlock: ^(FLLogger* logger){
        logger.indentLevel++;
    }];
}

- (void) stringFormatterOutdent:(FLStringFormatter*) stringFormatter {
    [self dispatchBlock: ^(FLLogger* logger){
        logger.indentLevel--;
    }];
}

- (void) logError:(NSError*) error {
    [self dispatchBlock: ^(FLLogger* logger){
        FLLogEntry* entry = [FLLogEntry logEntry];
        entry.logType = FLLogTypeError;
        entry.indentLevel = _indentLevel;
        entry.error = error;
        entry.stackTrace = error.stackTrace;
        [self sendEntryToSinks:entry];
    }];
}

- (void) logException:(NSException*) exception withComment:(NSString*) comment {
    [self dispatchBlock: ^(FLLogger* logger){
        FLLogEntry* entry = [FLLogEntry logEntry];
        entry.logString = comment;
        entry.logType = FLLogTypeException;
        entry.indentLevel = _indentLevel;
        entry.exception = exception;
        entry.stackTrace = exception.error.stackTrace;
        [self sendEntryToSinks:entry];
    }];
}

- (NSUInteger) stringFormatterGetLength:(FLStringFormatter*) stringFormatter {
    return _length;
}

//- (void) logException:(NSException*) exception withComment:(NSString*) comment {
//
//    [self dispatchBlock: ^{
//        for(id<FLLogSink> sink in _sinks) {
//            [sink logger:self openEntryWithLogType:FLLogTypeException];
//            [sink stringFormatterOpenLine:self];
//            [sink logger:self appendException:exception];
//            if(FLStringIsNotEmpty(comment)) {
//                [sink stringFormatter:self appendString:comment];
//            }
//            [sink loggerCloseEntry:self];
//        }
//    }];
//
////    FLLogEntry* entry = [FLLogEntry logEntry];
////    entry.exception = exception;
////    
////    NSString* info = [NSString stringWithFormat:@"name: %@, reason: %@", exception.name, exception.reason];
////    
////    if(comment) {
////        comment = [NSString stringWithFormat:@"%@ (%@)", comment, info];
////    }
////    else {
////        comment = info;
////    }
////    
////    entry.logString = comment;
////    entry.stackTrace = [FLStackTrace stackTraceWithException:exception];
////
////    [self sendEntryToSinks:entry];
//}

- (void) logException:(NSException*) exception {
    [self logException:exception withComment:nil];
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

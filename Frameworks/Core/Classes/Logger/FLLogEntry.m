//
//  FLLogEntry.m
//  FLCore
//
//  Created by Mike Fullerton on 11/1/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLLogEntry.h"
#import "FishLampCore.h"

@interface FLLogEntry () 
@property (readwrite, strong, nonatomic) NSString* logName;
@property (readwrite, assign, nonatomic) uint32_t logCount;
@property (readwrite, assign, nonatomic) NSTimeInterval timestamp;
- (void) updateTimestamp;
@end

@implementation FLLogEntry

@synthesize logString = _logString;
@synthesize logType = _logType;
@synthesize logName = _logName;
@synthesize stackTrace = _stackTrace;
@synthesize logCount = _logCount;
@synthesize timestamp = _timestamp;
@synthesize error = _error;
@synthesize exception = _exception;
@synthesize indentLevel = _indentLevel;

static NSMutableArray* s_cache = nil;

+ (void) initialize {
    if(!s_cache) {
        s_cache = [[NSMutableArray alloc] init];
    }
}

#if FL_MRC
- (void) dealloc {
    [_logString release];
    [_logType release];
    [_logName release];
    [_stackTrace release];
    [_error release];
    [_exception release];
    [super dealloc];
}
#endif

- (id) init {
    self = [super init];
    if(self) {
        [self updateTimestamp];
    }
    return self;
}

+ (id) logEntry {

    id entry = [s_cache lastObject];
    if(entry) {
        [entry updateTimestamp];
        return entry;
    }

    return FLAutorelease([[[self class] alloc] init]);
}

- (void) updateTimestamp {
    static uint32_t s_counter = 0;
    _logCount = ++s_counter;
    _timestamp = [NSDate timeIntervalSinceReferenceDate];
}

- (void) releaseToCache {
    self.logString = nil;
    self.logType = nil;
    self.logName = nil;
    self.stackTrace = nil;
    self.error = nil;
    self.exception = nil;
    _timestamp = 0;

    [s_cache addObject:self];
}

- (id)copyWithZone:(NSZone *)zone {
    FLLogEntry* entry = [[FLLogEntry alloc] init];
    entry.logString = self.logString;
    entry.logType = self.logType;
    entry.logName = self.logName;
    entry.stackTrace = self.stackTrace;
    entry.logCount = self.logCount;
    entry.timestamp = self.timestamp;
    entry.error = self.error;
    entry.exception = self.exception;
    entry.indentLevel = self.indentLevel;
    return entry;
}

- (NSString*) logString {
    return _logString ? _logString : @"";
}

- (NSError*) error {
    if(_error) {
        return _error;
    }
    
    if(_exception.error) {
        return _exception.error;
    }
    
    return nil;
}

@end


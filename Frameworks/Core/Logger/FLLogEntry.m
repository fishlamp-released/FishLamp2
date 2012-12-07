//
//  FLLogEntry.m
//  FLCore
//
//  Created by Mike Fullerton on 11/1/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLLogEntry.h"

@interface FLLogEntry () 
@property (readwrite, strong) NSString* logString;
@property (readwrite, strong) NSString* logType;
@property (readwrite, strong) NSString* logName;
@property (readwrite, strong) FLStackTrace* stackTrace;
@property (readwrite, assign) uint32_t logCount;
@property (readwrite, assign) NSTimeInterval timestamp;
@end

@implementation FLLogEntry

@synthesize logString = _logString;
@synthesize logType = _logType;
@synthesize logName = _logName;
@synthesize stackTrace = _stackTrace;
@synthesize logCount = _logCount;
@synthesize timestamp = _timestamp;

#if FL_MRC
- (void) dealloc {
    [_logString release];
    [_logType release];
    [_logName release];
    [_stackTrace release];
    [super dealloc];
}
#endif

- (void) preparePacketForDelivery:(NSString*) log 
                       forLogType:(NSString*) logType 
                       forLogName:(NSString*) logName 
                       stackTrace:(FLStackTrace*) stackTrace
                         logCount:(int32_t) logCount {

    self.logString = log;
    self.logType = logType;
    self.logName = logName;
    self.stackTrace = stackTrace;
    _timestamp = [NSDate timeIntervalSinceReferenceDate];
    _logCount = logCount;
}

- (void) setPacketWasDelivered {
    self.logString = nil;
    self.logType = nil;
    self.logName = nil;
    self.stackTrace = nil;
    _timestamp = 0;
}

- (id)copyWithZone:(NSZone *)zone {
    FLLogEntry* entry = [[FLLogEntry alloc] init];
    entry.logString = self.logString;
    entry.logType = self.logType;
    entry.logName = self.logName;
    entry.stackTrace = self.stackTrace;
    entry.logCount = self.logCount;
    entry.timestamp = self.timestamp;
    return entry;
}

+ (id) logEntry {
    return FLAutorelease([[[self class] alloc] init]);
}

@end


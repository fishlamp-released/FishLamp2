//
//  FLLogEntry.h
//  FLCore
//
//  Created by Mike Fullerton on 11/1/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCoreRequired.h"

@class FLStackTrace;

@interface FLLogEntry : NSObject<NSCopying> {
@private
    NSString* _logString;
    NSString* _logType;
    NSString* _logName;
    uint32_t _logCount;
    NSTimeInterval _timestamp;
    FLStackTrace* _stackTrace;
    NSError* _error;
    NSException* _exception;
    NSUInteger _indentLevel;
} 

+ (id) logEntry;

@property (readwrite, assign, nonatomic) NSUInteger indentLevel;
@property (readwrite, strong, nonatomic) NSError* error;
@property (readwrite, strong, nonatomic) NSException* exception;
@property (readwrite, strong, nonatomic) NSString* logString;
@property (readwrite, strong, nonatomic) NSString* logType;
@property (readonly, strong, nonatomic) NSString* logName;
@property (readwrite, strong, nonatomic) FLStackTrace* stackTrace;
@property (readonly, assign, nonatomic) uint32_t logCount;
@property (readonly, assign, nonatomic) NSTimeInterval timestamp;

- (void) releaseToCache;

@end

//
//  FLLogEntry.h
//  FLCore
//
//  Created by Mike Fullerton on 11/1/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLRequired.h"

@interface FLLogEntry : NSObject<NSCopying> {
@private
    NSString* _logString;
    NSString* _logType;
    NSString* _logName;
    uint32_t _logCount;
    NSTimeInterval _timestamp;
    FLStackTrace* _stackTrace;
} 

+ (id) logEntry;

@property (readonly, strong) NSString* logString;
@property (readonly, strong) NSString* logType;
@property (readonly, strong) NSString* logName;
@property (readonly, strong) FLStackTrace* stackTrace;
@property (readonly, assign) uint32_t logCount;
@property (readonly, assign) NSTimeInterval timestamp;

@end

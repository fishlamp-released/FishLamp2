//
//  FLLogSink.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/22/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLRequired.h"
#import "FLLogEntry.h"

#define FLLogTypeInvalid    nil
#define FLLogTypeLog        @"com.fishlamp.log"
#define FLLogTypeDiagnostic @"com.fishlamp.diagnostic"
#define FLLogTypeTrace      @"com.fishlamp.trace"
#define FLLogTypeDebug      @"com.fishlamp.debug"
#define FLLogTypeError      @"com.fishlamp.error"
#define FLLogTypeTest       @"com.fishlamp.unit-test"
#define FLLogTypeDatabase   @"com.fishlamp.database"
#define FLLogTypeException  @"com.fishlamp.exception"

@protocol FLLogSink <NSObject>
- (void) appendLogEntry:(FLLogEntry*) entry
                   stop:(BOOL*) stop;
@end

typedef enum {
    FLLogOutputSimple           = 0,
    FLLogOutputWithLocation     = (1 << 1),
    FLLogOutputWithStackTrace   = (1 << 2)
} FLLogSinkOutputFlags;

@interface FLLogSink : NSObject<FLLogSink> {
@private
    FLLogSinkOutputFlags _outputFlags;
}

+ (FLLogSink*) logSink:(FLLogSinkOutputFlags) output;

- (void) openEntry;
- (void) appendLine:(NSString*) line; // required ovveride
- (void) closeEntry;


@end



//
//  FLLogSink.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/22/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLRequired.h"
#import "FLStringFormatter.h"
#import "FLLogEntry.h"

typedef enum {
    FLLogOutputSimple           = 0,
    FLLogOutputWithLocation     = (1 << 1),
    FLLogOutputWithStackTrace   = (1 << 2)
} FLLogSinkOutputFlags;

@class FLLogger;

@protocol FLLogSink <NSObject>
- (void) logEntry:(FLLogEntry*) entry stopPropagating:(BOOL*) stop;
@end

@interface FLLogSink : NSObject<FLLogSink> {
@private
    FLLogSinkOutputFlags _outputFlags;
}
- (id) initWithOutputFlags:(FLLogSinkOutputFlags) outputFlags;

@property (readwrite, assign) FLLogSinkOutputFlags outputFlags;
@end



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
@synthesize outputFlags = _outputFlags;

- (id) initWithOutputFlags:(FLLogSinkOutputFlags) outputFlags  {

    self = [super init];
    if(self) {
        _outputFlags = outputFlags;
    }
    
    return self;
}

- (id) init {
    return [self initWithOutputFlags:0];
}

- (void) logEntry:(FLLogEntry*) entry 
             stop:(BOOL*) stop {
}

@end





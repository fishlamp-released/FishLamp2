//
//  FLPrintfLogSink.m
//  FishLampCore
//
//  Created by Mike Fullerton on 11/1/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLPrintfLogSink.h"
#import "FLPrintf.h"

@implementation FLPrintfLogSink

- (id) init {
    self = [super init];
    if(self) {
    }
    return self;
}

- (void) appendLine:(NSString*) line {
    FLPrintf(@"%@\n", line);
}
@end

//
//  FLUsageToolTask.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/9/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLUsageToolTask.h"

@implementation FLUsageToolTask

- (id) init {
    self = [super initWithKeys:@"--usage" ];
    if(self) {
    }
    return self;
}

- (id) parseOptionData:(FLParseableInput*) input siblings:(NSDictionary*) siblings {

//    NSMutableSet* tasks = [NSMutableSet set];
//    
//    for(FLToolTask* task in [self.tasks objectEnumerator]) {
//        [tasks addObject:task];
//    }
//
//    NSString* leader = [NSString stringWithFormat:@"usage: %@ ", [self.parent taskName]];
//    [self.output appendString:leader];
//
//    for(FLToolTask* task in tasks) {
//        [self.output appendFormat:@"[%@] ", [task buildUsageString]];
//    }
//    
//    [self.output closeLine];
//    
//    [self.output appendLineWithFormat:@"%@[<args>]", [@"" stringWithPadding:leader.length]];

    return nil;
}

@end

//
//  FLHelpToolTask.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/9/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLHelpToolTask.h"

@implementation FLHelpToolTask

- (id) init {
    self = [super initWithKeys:@"Help, ?, --help" ];
    if(self) {
    }
    return self;
}

- (id) parseOptionData:(FLParseableInput*) input siblings:(NSDictionary*) siblings {

//    [self.parent handleStringInput:@"--usage"];

//    [self.output appendBlankLine];
//    [self.output appendLineWithFormat:@"Help for %@:", [self.parent taskName]];
//    
//    NSMutableSet* tasks = [NSMutableSet set];
//    
//    for(FLToolTask* task in [[self.parent tasks] objectEnumerator]) {
//        [tasks addObject:task];
//    }
//
//    for(FLToolTask* task in tasks) {
//        [task printHelpToStringFormatter:self.output];
//    }

    return nil;
}

@end
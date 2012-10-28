//
//  FLWorkerBot.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/22/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLWorkerBot.h"

//@interface FLWorkerBot ()
//@property (readwrite, copy, nonatomic) FLCompletionBlock block;
//@end
//
//@implementation FLWorkerBot
//
//@synthesize block = _block;
//
//- (id) initWithBlock:(dispatch_block_t) block {
//    self = [super init];
//    if(self) {
//        self.block = block;
//    }
//
//    return self;
//}
//
//+ (id) workerBot:(dispatch_block_t) block {
//    return FLReturnAutoreleased([[[self class] alloc] initWithBlock:block]);
//}
//
//#if FL_NO_ARC
//- (void) dealloc {
//    [_block release];
//    [super dealloc];
//}
//#endif
//
//- (void) startWorking:(FLFinisher*) finisher {
//    if(_block) {
//        _block(finisher);
//    }
//    else {
//        [super startWorking:finisher];
//    }
//}
//
//@end
//

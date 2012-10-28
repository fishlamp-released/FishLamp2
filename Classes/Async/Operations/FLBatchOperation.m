//
//  FLBatchOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/11/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLBatchOperation.h"

@interface FLBatchOperation ()
@property (readwrite, assign) NSUInteger completedCount;
@property (readwrite, assign) NSUInteger batchCount;

@end

@implementation FLBatchOperation

@synthesize completedCount = _completedCount;
@synthesize batchCount = _batchCount;

- (id) init {
    self = [super init];
    if(self) {
        _queue = [NSMutableArray new];
    }
    
    return self;
}

- (void) dealloc {
#if FL_NO_ARC
    [_queue release];
    [super dealloc];
#endif
}

- (void) addBatchObjects:(NSArray*) batchObjects {
    @synchronized(self) {
        [_queue addObjectsFromArray:batchObjects];
        self.batchCount++;
    }
}

- (void) processBatchObject:(id) object {

}

- (void) runSelf {

    while(!self.didFail && !self.wasCancelled) {
    
        id object = nil;
        @synchronized(self) {
            if(_queue.count > 0) {
                object = [_queue firstObject];
                FLRetain(FLReturnAutoreleased(object));
                [_queue removeObjectAtIndex:0];
            }
        }
        
        if(!object) {
            break;
        }
        
        [self processBatchObject:object];

        self.completedCount++;

        [self postObservation:@selector(batchOperation:didProccessObject:) withObject:object];
    }
}




@end

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
@property (readonly, strong) NSArray* queue;
@end

@implementation FLBatchOperation

@synthesize completedCount = _completedCount;
@synthesize batchCount = _batchCount;
@synthesize queue = _queue;

- (id) init {
    self = [super init];
    if(self) {
        _queue = [NSMutableArray new];
    }
    
    return self;
}

- (void) dealloc {
#if FL_MRC
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

- (void) processBatchObject:(id) object inContext:(id) context withObserver:(id) observer {

}

- (FLResult) runOperationInContext:(id) context withObserver:(id) observer {

    while(YES) {
    
        id object = nil;
        @synchronized(self) {
            if(_queue.count > 0) {
                object = FLAutorelease(FLRetain([_queue firstObject]));
                [_queue removeObjectAtIndex:0];
            }
        }
        
        if(!object) {
            break;
        }
        
        [self abortIfNeeded];
        
        [self processBatchObject:object inContext:context withObserver:observer];

        self.completedCount++;

//        [self postObservation:@selector(batchOperation:didProccessObject:) withObject:object];
    }
    
    return FLSuccessfullResult;
}




@end

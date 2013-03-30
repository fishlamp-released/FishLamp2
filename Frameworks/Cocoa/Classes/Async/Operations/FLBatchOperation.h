//
//  FLBatchOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/11/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLSynchronousOperation.h"

#import "FLOperationQueue.h"

@interface FLBatchOperation : FLSynchronousOperation {
@private
	NSUInteger _completedCount;
	NSUInteger _batchCount;
	NSMutableArray* _queue;
}

@property (readonly, assign) NSUInteger completedCount;
@property (readonly, assign) NSUInteger batchCount;

- (void) addBatchObjects:(NSArray*) batchObjects;

- (void) processBatchObject:(id) object;

@end


@protocol FLBatchOperationObserver <NSObject>
- (void) batchOperation:(FLBatchOperation*) operation didProccessObject:(id) object;
@end
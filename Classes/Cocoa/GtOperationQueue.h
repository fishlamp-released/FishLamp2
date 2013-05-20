//
//	GtOperationQueue.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/4/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtOperation.h"

typedef void (^GtConfigureOperationBlock)(id operation); 
 
@interface GtOperationQueue : GtOperation {
@private
	NSMutableArray* m_operations;
	GtOperation* m_currentOperation;
    GtOperation* m_failedOperation;
    BOOL m_cancelled;
} 

@property (readonly, assign, nonatomic) id failedOperation;
@property (readonly, assign, nonatomic) id lastOperation; 
@property (readonly, assign, nonatomic) NSUInteger operationCount;

- (void) queueOperation:(GtOperation*) operation;
- (void) queueOperation:(GtOperation*) operation 
     configureOperation:(GtConfigureOperationBlock) configureAction;

- (id) operationById:(id) operationId;
- (id) operationByTag:(NSInteger) operationTag;
- (id) operationByClass:(Class) class;
- (id) operationAtIndex:(NSUInteger) idx;

@end

@interface GtOperationQueue (GtOutputHelpers) 
@property (readonly, retain, nonatomic) id lastOperationOutput;
- (id) outputById:(id) operationId;
- (id) outputByTag:(NSInteger) operationTag;
- (id) outputByIndex:(NSUInteger) operationIndex;
- (id) outputByOperationClass:(Class) aClass;
@end

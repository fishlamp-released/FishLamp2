//
//	FLOperationQueue.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/4/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLSynchronousOperationQueueOperation.h"

@interface FLSynchronousOperationQueueOperation ()
@property (readwrite, strong) FLOperation* currentOperation;
@property (readwrite, strong) FLOperationQueue* operationQueue;
@end

@implementation FLSynchronousOperationQueueOperation

@synthesize currentOperation = _currentOperation;
@synthesize operationQueue = _operationQueue;

//@synthesize delegate = _delegate;
@synthesize delegateActions = _delegateActions;
@synthesize observerActions = _observerActions;

- (id) initWithOperationQueue:(FLOperationQueue*) operationQueue {	
	self = [super init];
	if(self) {
        self.operationQueue = operationQueue;
	}
	return self;
}

+ (FLOperationQueue*) synchronousOperationQueueOperation:(FLOperationQueue*) queue {
    return FLAutorelease([[[self class] alloc] initWithOperationQueue:queue]);
}

#if FL_MRC 
- (void) dealloc {
    [_operationQueue release];
    [_currentOperation release];
    [super dealloc];
}
#endif

- (FLResult) performSynchronously {

    id outResult = [NSMutableDictionary dictionary];
    
    for(FLOperation* operation in _operationQueue) {
        
        id operationResult = nil;
        self.currentOperation = operation;
        @try {
            operationResult = [self runChildSynchronously:operation];
        }
        @catch(NSException* ex) {
            operationResult = FLRetainWithAutorelease(ex.error);
        }

        [outResult setObject:operationResult forKey:operation.identifier];
       
        if(self.abortNeeded || [operationResult isErrorResult]) {
            break;
        }
    }

    return outResult;
}

//- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state 
//                                  objects:(id __unsafe_unretained [])buffer 
//                                    count:(NSUInteger)len {
//    return [_operations countByEnumeratingWithState:state objects:buffer count:len];
//}

@end

@implementation FLOperationQueue (FLSynchronousOperationQueueOperation)

- (id) lastOperationOutput:(NSDictionary*) inResult {
    return [inResult objectForKey:[[self lastOperation] identifier]];
}

- (id) firstOperationOutput:(NSDictionary*) inResult {
    return [inResult objectForKey:[[self firstOperation] identifier]];
}

//- (id) outputByOperationClass:(Class) aClass inResult:(NSDictionary*) inResult {
//    return [inResult objectForKey:[[self operationByClass:aClass] identifier]];
//}

@end
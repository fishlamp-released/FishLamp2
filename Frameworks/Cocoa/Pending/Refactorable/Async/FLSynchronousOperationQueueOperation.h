//
//	FLSynchronousOperationQueueOperation.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/4/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaRequired.h"
#import "FLSynchronousOperation.h"
#import "FLOperationQueue.h"

typedef struct {
    SEL operationWillRun;
    SEL operationDidFinish;
} FLOperationQueueActions;

@interface FLSynchronousOperationQueueOperation : FLSynchronousOperation {
@private
    FLSynchronousOperation* _currentOperation;
    FLOperationQueue* _operationQueue;
    
//    __unsafe_unretained id _delegate;
    FLOperationQueueActions _observerActions;
    FLOperationQueueActions _delegateActions;
}

//@property (readwrite, assign, nonatomic) id delegate;
@property (readwrite, assign, nonatomic) FLOperationQueueActions delegateActions;
@property (readwrite, assign, nonatomic) FLOperationQueueActions observerActions;

@property (readonly, strong) FLOperationQueue* operationQueue;

+ (FLSynchronousOperationQueueOperation*) synchronousOperationQueueOperation:(FLOperationQueue*) queue;

@end


@interface FLOperationQueue (FLSynchronousOperationQueueOperation)
- (id) lastOperationOutput:(NSDictionary*) inResult;
- (id) firstOperationOutput:(NSDictionary*) inResult;
//- (id) outputByOperationClass:(Class) aClass inResult:(NSDictionary*) inResult;
@end

@protocol FLOperationQueueObserver <NSObject>
@optional
- (void) operationQueue:(FLOperationQueue*) queue operationWasAdded:(id) operation;
- (void) operationQueue:(FLOperationQueue*) queue operationWasRemoved:(id) operation;
- (void) operationQueue:(FLOperationQueue*) queue operationWillRun:(id) operation;
- (void) operationQueue:(FLOperationQueue*) queue operationDidFinish:(id) operation withResult:(id) result error:(NSError*) error;
@end
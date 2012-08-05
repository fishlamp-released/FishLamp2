//
//	FLOperation.m
//	FishLamp
//
//	Created by Mike Fullerton on 8/28/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLOperation.h"
#import "FLOperationQueue.h"
#import "FLOperationAuthenticator.h"

#ifdef DEBUG
#define TRACE 0
#endif

@interface FLOperation ()
@property (readonly, assign, nonatomic) BOOL wasStarted; // always call finishOperation if call startOperation
- (void) _setWasPerformed;
@property (readwrite, retain, nonatomic) id previousOperation;
@property (readwrite, retain, nonatomic) id nextOperation;
@end

@implementation FLOperation

FLSynthesizeStructProperty(shouldPerform, setShouldPerform, BOOL, _operationState);
FLSynthesizeStructProperty(securityBehavior, setSecurityBehavior, FLOperationAuthenticationBehavior, _operationState);

@synthesize operationId = _operationId;
@synthesize previousOperation = _previousOperation;
@synthesize parentOperationQueue = _parentOperationQueue;
@synthesize authenticator = _authenticator;
@synthesize state = _state;
@synthesize operationTag = _tag;
@synthesize onPerform = _performCallback; 
@synthesize onWillStart = _willPerformCallback;
@synthesize onFinished = _didPerformCallback;
@synthesize nextOperation = _nextOperation;

// TODO(use a observer to implement security stuff?)
@synthesize securityCredentials = _securityCredentials;

- (id) init {
	if((self = [super init])) {
		_operationState.shouldPerform = YES;
		_operationState.wasPerformed = NO;
		_operationState.wasCancelled = NO;
		self.securityBehavior = FLOperationAuthenticationBehaviorNone;
    }
	
	return self;
}

- (id) initWithPerformCallback:(FLOperationBlock) callback {
    if((self = [self init])) {
        self.onPerform = callback;
    }
    return self;
}

- (BOOL) wasStarted {
	return _operationState.wasStarted;
}

- (NSError*) error  {
    @synchronized(self) {
        return _error; 
    }
    return nil;// for compiler
}

- (void) insertNextOperation:(FLOperation*) operation  {
    if(self.parentOperationQueue) {
        [self.parentOperationQueue insertOperation:operation afterOperation:self];
    }
}

- (void) setError:(NSError*) error  {
    @synchronized(self) {
        FLAssignObject(_error, error);
#if DEBUG
        if(_error && !_error.isCancelError) {
            FLDebugLog(@"operation got error:%@", [_error description]);
        }
#endif
    }
}

- (void) addObserver:(id<FLOperationObserver>) observer {
    if(!_observers) {
        _observers = [[NSMutableArray alloc] init];
    }
    
    [_observers addObject:observer];
}

- (void) visitObserversWithSelector:(SEL) sel {
    for(id observer in _observers) {
        if([observer respondsToSelector:sel]) {
            [observer performSelector:sel withObject:self];
        }
    }
}

+ (id) operation {
	return FLReturnAutoreleased([[[self class] alloc] init]);
}

+ (id) operation:(FLOperationBlock) callback {
    return FLReturnAutoreleased([[[self class] alloc] initWithPerformCallback:callback]);
}

#if FL_DEALLOC
- (void) dealloc {
    FLRelease(_observers);
    FLRelease(_performCallback);
    FLRelease(_willPerformCallback);
    FLRelease(_didPerformCallback);
    FLRelease(_operationId);
    FLRelease(_error);
	FLRelease(_securityCredentials);
	FLRelease(_state);
	FLRelease(_operationInput);
	FLRelease(_operationOutput);
    FLRelease(_nextOperation);
    FLRelease(_previousOperation);
	FLSuperDealloc();
}
#endif

- (void) performSelf {
	if(self.onPerform) {
        self.onPerform(self);
    }
}

- (BOOL) didFail {
	return self.error != nil;
}

- (BOOL) wasPerformed {
	return _operationState.wasPerformed;
}

- (BOOL) wasCancelled {
    @synchronized(self) {
        return (BOOL) _operationState.wasCancelled || (_error && _error.isCancelError);
    }
    
    return NO;
}

- (void) requestCancel {
    @synchronized(self) {
        if(!_operationState.wasCancelled)  {
            FLAssignObject(_error, [NSError cancelError]);
            _operationState.wasCancelled = YES;
        }
    }
}

- (void) throwIfCancelled {
	if(self.wasCancelled) {
		FLThrowError([NSError cancelError]);
	}	
}

//- (void) describeSelf:(FLStringBuilder*) builder {
//	[super describeSelf:builder];
//	if(self.input) {
//		[builder appendLineWithFormat:@"input: %@", [self.operationInput defaultDescription]];
//	}
//	
//    if(self.output) {
//		[builder appendLineWithFormat:@"output: %@", [self.operationOutput defaultDescription]];
//	}
//	
//    if(self.error) {
//		[self.error describeToStringBuilder:builder];
//	}
//}
//
//- (NSString*) description {
//	return [self prettyDescription];
//}

//- (BOOL) willPrettyDescribe {
//	return YES;
//}

- (void) setWasPerformed:(BOOL) wasPerformed {
	_operationState.wasPerformed = wasPerformed;
}

- (BOOL) didFinishWithoutError {
	return self.error == nil && !self.wasCancelled && self.wasPerformed;
}

- (void) prepareOperation {
}

- (void) operationSetup {
}

- (void) operationTeardown {
}

- (void) willPerformOperation {
    if(self.onWillStart) {
        self.onWillStart(self);
    }
}

- (void) shouldPerformOperation {
}

#define AbortPeformanceIfNeeded() if(!self.shouldPerform || self.error || self.wasCancelled) goto abort

- (void) _perform {
#if TRACE
        if(!self.shouldPerform) {
            FLDebugLog(@"should perform is NO");
        }
#endif
        AbortPeformanceIfNeeded();
        if(self.authenticator ) {
            [self.authenticator configureDefaultSecurityForOperation:self];
        }

// should perform stage    
        AbortPeformanceIfNeeded();
        [self shouldPerformOperation];
        [self visitObserversWithSelector:@selector(operationShouldPerform:)];
        AbortPeformanceIfNeeded();


// will perform stage
#if TRACE
        FLDebugLog(@"will perform operation: %@", [self descriptor]);
#endif  
        AbortPeformanceIfNeeded();
        
        _operationState.wasStarted = YES;
        [self willPerformOperation];
        [self visitObserversWithSelector:@selector(operationWillPerform:)];
                                         
        [self operationSetup];
        
        if(self.authenticator) {
#if TRACE
            FLDebugLog(@"starting authentication for operation: %@", [self descriptor]);
#endif
            self.error = [self.authenticator authenthicateOperation:self];
        }

// perform it 
        AbortPeformanceIfNeeded();

        [self performSelf];
        
    return;

abort:
#if TRACE
    FLDebugLog(@"operation aborted: %@", [self description]);
#endif 

    ; // yes, this semicolon is needed.
}

- (void) performSynchronously {
    @try  {
        [self _perform];
    }
    @catch(NSException* ex) {
    	self.error = ex.error;
	}

	if(!self.wasCancelled && self.wasStarted) {
		_operationState.wasPerformed = YES;
	}
	
	if(self.wasPerformed) {
		[self operationWasPerformed];
        [self visitObserversWithSelector:@selector(operationWasPerformed:)];
	}
		
	if(self.wasStarted) {
		[self operationTeardown];
	}
	
	self.parentOperationQueue = nil;
	
#if TRACE
	FLDebugLog(@"finishing operation: %@", NSStringFromClass([self class]));
#endif	
}

- (void) operationWasPerformed {
    if(self.onFinished) {
        self.onFinished(self);
    }
}

- (BOOL) requiresNetwork {
	return NO;
}

- (void) _setWasPerformed {
	self.wasPerformed = YES;
}

- (id) operationInput {
	return self.input;
}

- (id) operationOutput {
	return self.output;
}

- (void) setOperationInput:(id) input {
    self.input = input;
}

- (void) setOperationOutput:(id) output {
    self.output = output;
}

- (id) nextObjectInLinkedList {
    return [self nextOperation];
}

- (void) setNextObjectInLinkedList:(id) next {
    self.nextOperation = (FLOperation*) next;
}

- (id) previousObjectInLinkedList {
    return [self previousOperation];
}

- (void) setPreviousObjectInLinkedList:(id) prev {
    self.previousOperation = (FLOperation*) prev;
}

@end

@implementation FLOperation (Deprecated)

- (id) output {
    return _operationOutput;
}

- (void) setOutput:(id) output {
    FLAssignObject(_operationOutput, output);
}

- (id) input {
    return _operationInput;
}

- (void) setInput:(id) input {
    FLAssignObject(_operationInput, input);
}

@end

@implementation FLWeakOperationObserver

@synthesize observer = _observer;

- (id) initWithObserver:(id) observer {
    self.observer = observer;
    return self;
}

+ (FLWeakOperationObserver*) weakOperationObserver:(id) observer {
    return FLReturnAutoreleased([[FLWeakOperationObserver alloc] initWithObserver:observer]);
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    if(self.observer && [self.observer respondsToSelector:[invocation selector]]) {
        [invocation invokeWithTarget:self.observer];
	}
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.observer methodSignatureForSelector:sel];
}

+ (BOOL)respondsToSelector:(SEL)aSelector {
    return YES;
}

@end


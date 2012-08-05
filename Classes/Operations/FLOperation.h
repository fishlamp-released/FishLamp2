//
//	FLOperation.h
//	FishLamp
//
//	Created by Mike Fullerton on 8/28/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//
#import "FishLampCocoa.h"

#import "FLCancellableOperation.h"

@class FLOperation;
@class FLOperationQueue;

@protocol FLOperationAuthenticator;

typedef enum
{
	FLOperationAuthenticationBehaviorUnknown		= 0,
	FLOperationAuthenticationBehaviorNone			= (1 << 1),
	FLOperationAuthenticationBehaviorAuthenticate	= (1 << 2),
	FLOperationAuthenticationBehaviorPrepare		= (1 << 3),
	FLOperationAuthenticationBehaviorSecure			= FLOperationAuthenticationBehaviorAuthenticate | FLOperationAuthenticationBehaviorPrepare
} FLOperationAuthenticationBehavior;

typedef void (^FLOperationBlock)(id operation); 

@protocol FLOperationObserver;

@interface FLOperation : NSObject<FLCancellableOperation>  {
@private	
    __weak FLOperationQueue* _parentOperationQueue;
	id _previousOperation;
	id _nextOperation;
	id _operationOutput;
	id _operationInput;
	id _operationId;
	FLOperationBlock _willPerformCallback;
	FLOperationBlock _didPerformCallback;
	FLOperationBlock _performCallback;
    NSMutableArray* _observers;
    id _state;
    NSError* _error;
    
	NSInteger _tag;
    struct {
		unsigned int wasPerformed:1;
		unsigned int shouldPerform:1;
		unsigned int wasCancelled:1;
		unsigned int wasStarted:1;
		FLOperationAuthenticationBehavior securityBehavior:4;     // deprecated
	} _operationState;

    // deprecated
	id<FLOperationAuthenticator> _authenticator;
  	id _securityCredentials;
}

- (id) init;
- (id) initWithPerformCallback:(FLOperationBlock) callback;

+ (id) operation;
+ (id) operation:(FLOperationBlock) callback;

// identity
@property (readwrite, retain, nonatomic) id operationId;
@property (readwrite, assign, nonatomic) NSInteger operationTag;

// state
@property (readwrite, assign, nonatomic) BOOL shouldPerform;
@property (readonly, assign, nonatomic) BOOL wasPerformed;
@property (readonly, assign, nonatomic) BOOL didFinishWithoutError; // wasPerformed, not cancelled, and no error
@property (readwrite, retain, nonatomic) id state; // whatever you need to use it for
@property (readwrite, retain) NSError* error;

// only valid while queue is performing operations.
@property (readonly, retain, nonatomic) id previousOperation;
@property (readonly, retain, nonatomic) id nextOperation;

- (void) insertNextOperation:(FLOperation*) operation;

@property (readwrite, assign, nonatomic) FLOperationQueue* parentOperationQueue; 

// event handlers
@property (readwrite, copy, nonatomic) FLOperationBlock onWillStart;
@property (readwrite, copy, nonatomic) FLOperationBlock onPerform; // won't call [self performSelf] if this is set.
@property (readwrite, copy, nonatomic) FLOperationBlock onFinished;

// input/output
// Note: we're not using properties here to give us some flexibily with subclasses.
- (id) operationOutput;
- (void) setOperationOutput:(id) output;

- (id) operationInput;
- (void) setOperationInput:(id) input;

// observers

// note that observers are retained. If you need an unretained observer, send it in enclosed in
// a FLWeakObserverObserver.

- (void) addObserver:(id<FLOperationObserver>) observer; 
- (void) visitObserversWithSelector:(SEL) sel;

// performing
- (void) performSynchronously;

// deprecated
// security

@property (readwrite, retain, nonatomic) id securityCredentials;
@property (readwrite, retain, nonatomic) id<FLOperationAuthenticator> authenticator;
@property (readwrite, assign, nonatomic) FLOperationAuthenticationBehavior securityBehavior; // only if it has a authenticator.

@end

@interface FLOperation (OptionalOverrides)

// these are called in the following order
- (void) shouldPerformOperation; // set willPerform flag to false here if needed.
- (void) willPerformOperation;  
- (void) operationSetup;
- (void) performSelf; 
- (void) operationWasPerformed;
- (void) operationTeardown; // teardown is ALWAYS called if operationSetup is called
@end

@interface FLOperation (Deprecated)
- (id) output;
- (void) setOutput:(id) output;

- (id) input;
- (void) setInput:(id) input;
@end

@protocol FLOperationObserver <NSObject>
@optional
- (void) operationShouldPerform:(FLOperation*) operation;
- (void) operationWillPerform:(FLOperation*) operation;
- (void) operationWasPerformed:(FLOperation*) operation;
- (void) operationWasFinalized:(FLOperation*) operation;
@end

@interface FLWeakOperationObserver : NSProxy<FLOperationObserver> {
@private
    __unsafe_unretained id _observer;
}
@property (readwrite, assign, nonatomic) id observer;
+ (FLWeakOperationObserver*) weakOperationObserver:(id) observer;
- (id) initWithObserver:(id) observer;
@end


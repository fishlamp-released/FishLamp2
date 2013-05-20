//
//	GtOperation.h
//	FishLamp
//
//	Created by Mike Fullerton on 8/28/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtCancellableOperation.h"
#import "GtWeakReference.h"

@class GtOperation;
@class GtOperationQueue;

@protocol GtOperationAuthenticator;

typedef enum
{
	GtOperationAuthenticationBehaviorUnknown		= 0,
	GtOperationAuthenticationBehaviorNone			= (1 << 1),
	GtOperationAuthenticationBehaviorAuthenticate	= (1 << 2),
	GtOperationAuthenticationBehaviorPrepare		= (1 << 3),
	GtOperationAuthenticationBehaviorSecure			= GtOperationAuthenticationBehaviorAuthenticate | GtOperationAuthenticationBehaviorPrepare
} GtOperationAuthenticationBehavior;

@protocol GtOperationContext <NSObject>
- (void) willPerformOperation:(id) operation;
- (void) didPerformOperation:(id) operation;
- (id) stateObjectForKey:(id) key;
- (void) setStateObject:(id) object forKey:(id) key;
@end

@interface GtOperation : NSObject<GtCancellableOperation>  {
@private	
    
	id m_previousOperation;
	GtOperationQueue* m_parentOperationQueue;
	id m_operationOutput;
	id m_operationInput;
	id m_securityCredentials;
	id m_operationId;
    NSInteger m_tag;
    GtBlock m_willPerformCallback;
	GtBlock m_didPerformCallback;
	GtBlock m_performCallback;

	id m_state;
    NSError* m_error;
	id<GtOperationAuthenticator> m_authenticator;
    
    id<GtOperationContext> m_operationContext;

	struct {
		unsigned int wasPerformed:1;
		unsigned int shouldPerform:1;
		unsigned int wasCancelled:1;
		unsigned int wasStarted:1;
		GtOperationAuthenticationBehavior securityBehavior:4;
	} m_operationState;
}

- (id) init;
+ (id) operation;

@property (readwrite, retain, nonatomic) id state;

@property (readwrite, retain) NSError* error;

@property (readwrite, retain, nonatomic) id operationInput;
@property (readwrite, retain, nonatomic) id operationOutput;

// security
@property (readwrite, retain, nonatomic) id securityCredentials;
@property (readwrite, retain, nonatomic) id<GtOperationAuthenticator> authenticator;
@property (readwrite, assign, nonatomic) GtOperationAuthenticationBehavior securityBehavior; // only if it has a authenticator.

// state
@property (readwrite, retain, nonatomic) id operationId;
@property (readwrite, assign, nonatomic) NSInteger operationTag;

@property (readwrite, assign, nonatomic) BOOL shouldPerform;
@property (readonly, assign, nonatomic) BOOL wasPerformed;

@property (readonly, assign, nonatomic) id<GtOperationContext> operationContext;

- (void) performSynchronously:(id<GtOperationContext>) contextOrNil;

@property (readonly, assign, nonatomic) BOOL didFinishWithoutError; // wasPerformed, not cancelled, and no error

// only valid while queue is performing operations.
@property (readwrite, assign, nonatomic) id previousOperation;
@property (readwrite, assign, nonatomic) GtOperationQueue* parentOperationQueue; 

@property (readwrite, copy, nonatomic) GtBlock performCallback; // won't call [self performSelf] if this is set.
@property (readwrite, copy, nonatomic) GtBlock willPerformCallback;
@property (readwrite, copy, nonatomic) GtBlock didPerformCallback;

// protected

@property (readonly, assign, nonatomic) BOOL wasStarted; // always call finishOperation if call startOperation

- (void) prepareOperation;

- (BOOL) willPerformOperation;
- (void) performSelf; 
- (void) operationWasPerformed;

- (void) operationSetup;
- (void) operationTeardown;

- (void) _setWasPerformed;

- (void) finalizeOperation;

@end

@interface GtOperation (Deprecated)
- (void) setDidPerformCallback:(id) target action:(SEL) action;
- (void) setWillPerformCallback:(id) target action:(SEL)action;

- (id) output;
- (void) setOutput:(id) output;

- (id) input;
- (void) setInput:(id) input;
@end




//
//	GtOperation.m
//	FishLamp
//
//	Created by Mike Fullerton on 8/28/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtOperation.h"
#import "GtOperationQueue.h"
#import "GtOperationAuthenticator.h"

#ifdef DEBUG
#define TRACE 0
#endif

@implementation GtOperation

GtSynthesizeStructProperty(shouldPerform, setShouldPerform, BOOL, m_operationState);
GtSynthesizeStructProperty(securityBehavior, setSecurityBehavior, GtOperationAuthenticationBehavior, m_operationState);

@synthesize operationId = m_operationId;
@synthesize previousOperation = m_previousOperation;
@synthesize parentOperationQueue = m_parentOperationQueue;
@synthesize authenticator = m_authenticator;
@synthesize state = m_state;
@synthesize securityCredentials = m_securityCredentials;
@synthesize operationContext = m_operationContext;
@synthesize operationTag = m_tag;
@synthesize performCallback = m_performCallback; // won't call [self performSelf] if this is set.
@synthesize willPerformCallback = m_willPerformCallback;
@synthesize didPerformCallback = m_didPerformCallback;

- (id) init
{
	if((self = [super init]))
	{
		m_operationState.shouldPerform = YES;
		m_operationState.wasPerformed = NO;
		m_operationState.wasCancelled = NO;
		self.securityBehavior = GtOperationAuthenticationBehaviorNone;
    }
	
	return self;
}

- (id) initWithPerformCallback:(GtBlock) callback
{
    if((self = [self init]))
    {
        self.performCallback = callback;
    }
    return self;
}

- (BOOL) wasStarted
{
	return m_operationState.wasStarted;
}

- (NSError*) error 
{
    @synchronized(self) {
        return m_error; 
    }
    return nil;// for compiler
}

- (void) setError:(NSError*) error 
{
    @synchronized(self) {
        GtAssignObject(m_error, error);
#if DEBUG
        if(m_error && !m_error.isCancelError)
        {
            GtLog(@"operation got error:%@", [m_error description]);
        }
#endif
    }
}

- (void) finalizeOperation
{
    GtReleaseBlockWithNil(m_performCallback);
    GtReleaseBlockWithNil(m_willPerformCallback);
    GtReleaseBlockWithNil(m_didPerformCallback);
}

+ (id) operation
{
	return GtReturnAutoreleased([[[self class] alloc] init]);
}

+ (id) operation:(GtBlock) callback
{
    return GtReturnAutoreleased([[[self class] alloc] initWithPerformCallback:callback]);
}

- (void) dealloc
{
    GtReleaseBlockWithNil(m_performCallback);
    GtReleaseBlockWithNil(m_willPerformCallback);
    GtReleaseBlockWithNil(m_didPerformCallback);
    GtRelease(m_operationId);
    GtRelease(m_error);
	GtRelease(m_securityCredentials);
	GtRelease(m_state);
	GtRelease(m_operationInput);
	GtRelease(m_operationOutput);
	GtSuperDealloc();
}

- (void) performSelf
{
	// override this
}

- (BOOL) onWillPerformOperation
{
	return YES;
}

- (BOOL) didFail
{
	return self.error != nil;
}

- (BOOL) wasPerformed
{
	return m_operationState.wasPerformed;
}

- (BOOL) wasCancelled
{
    @synchronized(self) {
        return (BOOL) m_operationState.wasCancelled || (m_error && m_error.isCancelError);
    }
    
    return NO;
}

- (void) requestCancel
{
    @synchronized(self) {
        if(!m_operationState.wasCancelled) 
        {
            GtAssignObject(m_error, [NSError cancelError]);
            m_operationState.wasCancelled = YES;
        }
    }
}

- (void) throwIfCancelled
{
	if(self.wasCancelled)
	{
		GtThrowError([NSError cancelError]);
	}	
}

//- (void) describeSelf:(GtStringBuilder*) builder
//{
//	[super describeSelf:builder];
//	if(self.input)
//	{
//		[builder appendLineWithFormat:@"input: %@", [self.operationInput defaultDescription]];
//	}
//	if(self.output)
//	{
//		[builder appendLineWithFormat:@"output: %@", [self.operationOutput defaultDescription]];
//	}
//	if(self.error)
//	{
//		[self.error describeToStringBuilder:builder];
//	}
//}
//
//- (NSString*) description
//{
//	return [self prettyDescription];
//}
//

- (void) setWasPerformed:(BOOL) wasPerformed
{
	m_operationState.wasPerformed = wasPerformed;
}

- (BOOL) didFinishWithoutError
{
	return self.error == nil && !self.wasCancelled && self.wasPerformed;
}

- (void) operationSetup
{
}

- (void) operationTeardown
{
}

- (BOOL) willPerformOperation
{
	return YES;
}

- (void) _updateShouldPerformFlag
{
	if(self.error || self.wasCancelled)
	{
		self.shouldPerform = NO;
	}
}

- (void) prepareOperation
{
}

- (void) performSynchronously:(id<GtOperationContext>) contextOrNil
{
    @try 
    {
        m_operationContext = contextOrNil;
#if TRACE
        if(!self.shouldPerform)
        {
            GtLog(@"should perform is NO");
        }
#endif

        [self _updateShouldPerformFlag];

        if(self.shouldPerform)
        {
            if(self.authenticator )
            {
                [self.authenticator configureDefaultSecurityForOperation:self];
            }
        
            GtBlock willPerformCallback = self.willPerformCallback;
            if(willPerformCallback)
            {
                willPerformCallback();
            }
        
            [self _updateShouldPerformFlag];
        
            [self prepareOperation];
        
            if(self.shouldPerform)
            {
                self.shouldPerform = [self willPerformOperation];
            }

            [self _updateShouldPerformFlag];
                                 
            if(self.shouldPerform)
            {
                m_operationState.wasStarted = YES;
                [self operationSetup];
                
                if(self.authenticator)
                {
#if TRACE
                    GtLog(@"starting authentication for operation: %@", NSStringFromClass([self class]));
#endif
                    self.error = [self.authenticator authenthicateOperation:self];
                }
                 
#if TRACE
                GtLog(@"starting operation: %@", NSStringFromClass([self class]));
#endif			  
                if(!self.error)
                {
                    [m_operationContext willPerformOperation:self];
                
                    GtBlock callback = self.performCallback;
                    if(callback)
                    {
                        callback();
                    }
                    else
                    {
                        [self performSelf];
                    }
                }
            }
        }
        
    }
    @catch(NSException* ex)
    {
    	self.error = ex.error;
	}

	if(!self.wasCancelled && self.wasStarted)
	{
		m_operationState.wasPerformed = YES;
	}
	
	if(self.wasPerformed)
	{
		[self operationWasPerformed];

        GtBlock didPerformCallback = self.didPerformCallback;
		if(didPerformCallback)
        {
        	didPerformCallback();
        }
        
        [m_operationContext didPerformOperation:self];
	}
		
	if(self.wasStarted)
	{
		[self operationTeardown];
	}
	
	self.parentOperationQueue = nil;
	m_operationContext = nil;
    
#if TRACE
	GtLog(@"finishing operation: %@", NSStringFromClass([self class]));
#endif	
}

- (void) operationWasPerformed
{
}

- (BOOL) requiresNetwork
{
	return NO;
}

- (void) _setWasPerformed
{
	self.wasPerformed = YES;
}

- (id) operationInput
{
	return self.input;
}

- (id) operationOutput
{
	return self.output;
}

- (void) setOperationInput:(id) input
{
    self.input = input;
}

- (void) setOperationOutput:(id) output
{
    self.output = output;
}

@end

@implementation GtOperation (Deprecated)

- (void) setWillPerformCallback:(id) target action:(SEL)action
{
    __unsafe_unretained id operation = self;

	self.willPerformCallback = ^{ [target performSelector:action withObject:operation]; };
}

- (void) setDidPerformCallback:(id) target action:(SEL) action
{
    __unsafe_unretained id operation = self;

	self.didPerformCallback = ^{ [target performSelector:action withObject:operation]; };
}

- (id) output
{
    return m_operationOutput;
}

- (void) setOutput:(id) output
{
    GtAssignObject(m_operationOutput, output);
}

- (id) input
{
    return m_operationInput;
}

- (void) setInput:(id) input
{
    GtAssignObject(m_operationInput, input);
}

@end




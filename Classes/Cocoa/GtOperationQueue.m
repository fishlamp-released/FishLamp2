//
//	GtOperationQueue.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/4/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtOperationQueue.h"

#if DEBUG
#define LOG 0
#endif
#if LOG
#warning LOG enabled
#endif

@implementation GtOperationQueue

@synthesize failedOperation = m_failedOperation;

- (id) init
{
	if((self = [super init]))
	{
		m_operations = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void) clearOperationQueue
{
	if(m_operations)
	{
		for(GtOperation* operation in m_operations)
		{
			[operation finalizeOperation];
		}
	
		[m_operations removeAllObjects];
	}
}

- (void) dealloc
{
	[self clearOperationQueue];
	GtRelease(m_operations);
	GtSuperDealloc();
}

- (void) finalizeOperation
{
	[super finalizeOperation];
	[self clearOperationQueue];
}

- (GtOperation*) currentOperation
{
	return m_currentOperation;
}

- (void) _runCurrentOperation:(GtOperation*) operation 
            previousOperation:(GtOperation*) previousOperation
{
    @try
    {
        m_currentOperation = operation;
        m_currentOperation.previousOperation = previousOperation;
        m_currentOperation.parentOperationQueue = self;

        [m_currentOperation performSynchronously:self.operationContext];
        
        if(m_currentOperation.error)
        {
            m_failedOperation = m_currentOperation;
        }
    }
    @finally 
    {
        m_currentOperation = nil;
        m_currentOperation.parentOperationQueue = nil;
    }
}

- (void) performSelf
{
	id previousOperation = nil;
	NSUInteger currentOperationIndex = 0;
    m_failedOperation = nil;

	while(  !m_cancelled && 
            !m_failedOperation && 
            currentOperationIndex < m_operations.count)
	{
        NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
		@try
		{
            GtOperation* operation = [m_operations objectAtIndex:currentOperationIndex];
            [self _runCurrentOperation:operation previousOperation:previousOperation];
            previousOperation = operation;
            
            GtDrainPool(&pool);
            ++currentOperationIndex;
		}
		@catch(NSException* ex)
		{
			GtDrainPoolAndRethrow(&pool, ex);
		}
	}
}

- (NSError*) error
{
	return m_failedOperation ? [m_failedOperation error] : [super error];
}

- (void) queueOperation:(GtOperation*) operation
{
	[self queueOperation:operation configureOperation:nil];
}

- (void) queueOperation:(GtOperation*) operation  
     configureOperation:(GtConfigureOperationBlock) configureAction
{
    GtAssertNotNil(operation);

	if(self.wasCancelled)
	{
		[operation requestCancel];
	}
	
	[m_operations addObject:operation];
	
	if(configureAction)
	{
		configureAction(operation);
	}
}

- (void) queueOperationWithBlock:(GtBlock) performBlock
{
    [self queueOperation:[GtOperation operation] configureOperation:^(id operation) {
        [operation setPerformCallback:performBlock];
        }];
}

- (void) insertOperation:(GtOperation*) operation atIndex:(NSUInteger) atIndex 
{
	[m_operations insertObject:operation atIndex:atIndex];
}

//- (void) describeSelf:(GtStringBuilder*) builder
//{
//	[super describeSelf:builder];
//	
//	for(GtOperation* operation in m_operations)
//	{
//		[operation describeToStringBuilder:builder];
//	}
//	
//	if(self.failedOperation)
//	{
//		[builder appendString:@"Failed Operation: "];
//		[self.failedOperation describeToStringBuilder:builder];
//	}
//}

- (id) operationAtIndex:(NSUInteger) idx
{
	GtAssert(idx >= 0 && idx < m_operations.count, @"bad idx");
	return [m_operations objectAtIndex:idx];
}

- (id) operationByTag:(NSInteger) operationTag
{
    GtAssert(operationTag != 0, @"tag must be nonzero");

    for(GtOperation* operation in m_operations)
    {
        if(operation.operationTag == operationTag)
        {   
            return operation;
        }
    }
    
    return nil;
}

- (id) operationById:(id) operationId
{
    GtAssertNotNil(operationId);

    if(operationId)
    {
        for(GtOperation* operation in m_operations)
        {
            if(operation.operationId && [operationId isEqual:operation.operationId])
            {   
                return operation;
            }
        }
    }
	
	return nil; 
}

- (id) operationByClass:(Class) class
{
	for(GtOperation* operation in m_operations)
	{
		if([operation isKindOfClass:class])
		{
			return operation;
		}
	}
	
	return nil;
}

- (id) lastOperation
{
	return [m_operations lastObject];
}

- (NSUInteger) operationCount
{
	return m_operations.count;
}

- (void) requestCancel
{
    [super requestCancel];
    m_cancelled = YES;
    [m_currentOperation requestCancel];
}

- (BOOL) wasCancelled
{
	return m_cancelled; 
}	

@end

@implementation GtOperationQueue (GtOutputHelpers)

- (id) lastOperationOutput
{
    return [[self lastOperation] operationOutput];
}

- (id) outputById:(id) operationId
{
    return [[self operationById:operationId] operationOutput];
}

- (id) outputByTag:(NSInteger) operationTag
{
    return [[self operationByTag:operationTag] operationOutput];
}

- (id) outputByIndex:(NSUInteger) operationIndex
{
    return [[self operationAtIndex:operationIndex] operationOutput];
}

- (id) outputByOperationClass:(Class) aClass
{
    return [[self operationByClass:aClass] operationOutput];
}

@end


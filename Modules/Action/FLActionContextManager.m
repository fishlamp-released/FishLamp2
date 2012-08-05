//
//	FLActionContextManager.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/9/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLActionContextManager.h"
#import "FLActionContext.h"

NSString* const FLActionManagerActionWillBegin	 		= @"FLActionManagerActionWillBegin";
NSString* const FLActionManagerActionDidFinish	 		= @"FLActionManagerActionDidFinish";

@implementation FLActionContextManager

FLSynthesizeSingleton(FLActionContextManager);

- (id) init
{
	if((self = [super init]))
	{
		_contextStack = [[NSMutableArray alloc] init];
	}
	
	return self;
}

- (void) addContext:(FLActionContext*) context
{
	[_contextStack addObject:[NSValue valueWithNonretainedObject:context]];
}

- (void) removeContext:(FLActionContext*) inContext
{
	for(NSInteger i = _contextStack.count - 1; i >= 0; i--)
	{
		FLActionContext* context = (FLActionContext*)[[_contextStack objectAtIndex:i] nonretainedObjectValue];
		if(context == inContext)
		{
			[_contextStack removeObjectAtIndex:i];
		}
	}
}

- (void) deactivateAllManagedContexts
{
	_flags.disableActivatePrevious = YES;

	for(NSInteger i = _contextStack.count - 1; i >= 0; i--)
	{
		FLActionContext* context = (FLActionContext*)[[_contextStack objectAtIndex:i] nonretainedObjectValue];
		if(context)
		{
			[context deactivate];	
		} 
	}
	
	_flags.disableActivatePrevious = NO;

}

- (void) activatePreviousContext:(FLActionContext*) inContext
{
	if(!_flags.disableActivatePrevious)
	{
		BOOL activateNext = NO;
		for(NSInteger i = _contextStack.count - 1; i >= 0; i--)
		{
			FLActionContext* context = (FLActionContext*)[[_contextStack objectAtIndex:i] nonretainedObjectValue];
			
			if(activateNext)
			{
				[context activate];
				break;
			}	
			else if(context == inContext)
			{
				activateNext = YES;
			}
			
		}
	}
 }

- (FLActionContext*) activeContext
{
	for(NSInteger i = _contextStack.count - 1; i >= 0; i--)
	{
		FLActionContext* context = (FLActionContext*)[[_contextStack objectAtIndex:i] nonretainedObjectValue];
		if(context.isActive)
		{
			return context;
		}
	}

	return nil;
}

@end

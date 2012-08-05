//
//	FLManagedActionContext.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/12/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLManagedActionContext.h"

#import "FLActionContextManager.h"

NSString* const FLActionContextWasActivated = @"FLActionContextWasActivated";
NSString* const FLActionContextWillBeginActionNotification= @"FLActionContextWillBeginActionNotification";
NSString* const FLActionContextDidFinishAllActionsNotification = @"FLActionContextDidFinishAllActionsNotification";

@implementation FLManagedActionContext

- (id) init
{
	if((self = [super init]))
	{
		[[FLActionContextManager instance] addContext:self];
	}
	return self;
}

- (id) initAndActivate:(BOOL) activate
{
	if((self = [super init]))
	{
		[[FLActionContextManager instance] addContext:self];
	
		if(activate)
		{
			[self activate];
		}
	}
	return self;
}

- (BOOL) deactivate
{
	if([super deactivate])
	{	
		[[FLActionContextManager instance] activatePreviousContext:self];
		return YES;
	}
	
	return NO;
}

- (BOOL) activate
{
	if(!self.isActive)
	{	
		[[FLActionContextManager instance] deactivateAllManagedContexts];
		[super activate];

        [[NSNotificationCenter defaultCenter] postNotification:
            [NSNotification notificationWithName:FLActionContextWasActivated object:[FLActionContextManager instance]]];

		return YES;
	}
	
	return NO;
}

- (void) dealloc
{
	[[FLActionContextManager instance] removeContext:self];
    FLSuperDealloc();
}

- (void) didFinishAllActions
{
	[[NSNotificationCenter defaultCenter] postNotification:
		[NSNotification notificationWithName:FLActionContextDidFinishAllActionsNotification object:[FLActionContextManager instance]]];
}

- (void) willBeginAction:(id<FLAsyncAction>) action
{
	[[NSNotificationCenter defaultCenter] postNotification:
		[NSNotification notificationWithName:FLActionContextWillBeginActionNotification object:[FLActionContextManager instance]]];
}

@end

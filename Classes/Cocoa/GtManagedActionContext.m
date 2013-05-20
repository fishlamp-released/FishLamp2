//
//	GtManagedActionContext.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/12/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtManagedActionContext.h"

#import "GtActionContextManager.h"

NSString* const GtActionContextWasActivated = @"GtActionContextWasActivated";
NSString* const GtActionContextWillBeginActionNotification= @"GtActionContextWillBeginActionNotification";
NSString* const GtActionContextDidFinishAllActionsNotification = @"GtActionContextDidFinishAllActionsNotification";

@implementation GtManagedActionContext

- (id) init
{
	if((self = [super init]))
	{
		[[GtActionContextManager instance] addContext:self];
	}
	return self;
}

- (id) initAndActivate:(BOOL) activate
{
	if((self = [super init]))
	{
		[[GtActionContextManager instance] addContext:self];
	
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
		[[GtActionContextManager instance] activatePreviousContext:self];
		return YES;
	}
	
	return NO;
}

- (BOOL) activate
{
	if(!self.isActive)
	{	
		[[GtActionContextManager instance] deactivateAllManagedContexts];
		[super activate];

        [[NSNotificationCenter defaultCenter] postNotification:
            [NSNotification notificationWithName:GtActionContextWasActivated object:[GtActionContextManager instance]]];

		return YES;
	}
	
	return NO;
}

- (void) dealloc
{
	[[GtActionContextManager instance] removeContext:self];
    GtSuperDealloc();
}

- (void) didFinishAllActions
{
	[[NSNotificationCenter defaultCenter] postNotification:
		[NSNotification notificationWithName:GtActionContextDidFinishAllActionsNotification object:[GtActionContextManager instance]]];
}

- (void) willBeginAction:(id<GtAction>) action
{
	[[NSNotificationCenter defaultCenter] postNotification:
		[NSNotification notificationWithName:GtActionContextWillBeginActionNotification object:[GtActionContextManager instance]]];
}

@end

//
//	GtCacheManager.m
//	FishLamp
//
//	Created by Mike Fullerton on 1/23/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtCacheManager.h"
#import "NSNotification+GtExtras.h"

NSString* const GtUserSessionEmptyCacheNotification = @"GtUserSessionEmptyCacheNotification";

@implementation GtCacheManager

GtSynthesizeSingleton(GtCacheManager);

- (void) broadcastEmptyCacheMessage:(id<GtCancellableOperation>) operation
{
	if(operation)
	{
		[[NSNotificationCenter defaultCenter] postNotification:
			[NSNotification notificationWithName:GtUserSessionEmptyCacheNotification object:[GtCacheManager instance] cancellableOperation:operation]];
	}
	else
	{
		[[NSNotificationCenter defaultCenter] postNotification:
			[NSNotification notificationWithName:GtUserSessionEmptyCacheNotification object:[GtCacheManager instance]]];
	}
}

@end

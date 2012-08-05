//
//	FLCacheManager.m
//	FishLamp
//
//	Created by Mike Fullerton on 1/23/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLCacheManager.h"
#import "NSNotification+FLExtras.h"

NSString* const FLUserSessionEmptyCacheNotification = @"FLUserSessionEmptyCacheNotification";

@implementation FLCacheManager

FLSynthesizeSingleton(FLCacheManager);

- (void) broadcastEmptyCacheMessage:(id<FLCancellableOperation>) operation
{
	if(operation)
	{
		[[NSNotificationCenter defaultCenter] postNotification:
			[NSNotification notificationWithName:FLUserSessionEmptyCacheNotification object:[FLCacheManager instance] cancellableOperation:operation]];
	}
	else
	{
		[[NSNotificationCenter defaultCenter] postNotification:
			[NSNotification notificationWithName:FLUserSessionEmptyCacheNotification object:[FLCacheManager instance]]];
	}
}

@end

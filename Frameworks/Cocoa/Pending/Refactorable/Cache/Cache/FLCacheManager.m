//
//	FLCacheManager.m
//	FishLamp
//
//	Created by Mike Fullerton on 1/23/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCacheManager.h"
#import "NSNotification+FLExtras.h"

NSString* const FLCacheManagerEmptyCacheNotification = @"FLCacheManagerEmptyCacheNotification";

@implementation FLCacheManager

FLSynthesizeSingleton(FLCacheManager);

- (void) broadcastEmptyCacheMessage:(id) operation
{
	if(operation)
	{
		[[NSNotificationCenter defaultCenter] postNotification:
			[NSNotification notificationWithName:FLCacheManagerEmptyCacheNotification object:[FLCacheManager instance] cancellableOperation:operation]];
	}
	else
	{
		[[NSNotificationCenter defaultCenter] postNotification:
			[NSNotification notificationWithName:FLCacheManagerEmptyCacheNotification object:[FLCacheManager instance]]];
	}
}

@end

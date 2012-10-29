//
//	NSNotification+FLExtras.m
//	FishLamp
//
//	Created by Mike Fullerton on 1/23/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "NSNotification+FLExtras.h"

NSString* const NSNotificationCancellableOperationKey = @"FLCancellable";

@implementation NSNotification (FLExtras)

+ (id)notificationWithName:(NSString *)aName object:(id)anObject cancellableOperation:(id<FLCancellable>) operation
{
	return [NSNotification notificationWithName:aName object:anObject userInfo:[NSDictionary dictionaryWithObject:operation forKey:NSNotificationCancellableOperationKey]];
}

- (id<FLCancellable>) cancellableOperation
{
	return [self.userInfo objectForKey:NSNotificationCancellableOperationKey];
}


@end

//
//	NSNotification+GtExtras.m
//	FishLamp
//
//	Created by Mike Fullerton on 1/23/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "NSNotification+GtExtras.h"

NSString* const NSNotificationCancellableOperationKey = @"GtCancellableOperation";

@implementation NSNotification (GtExtras)

+ (id)notificationWithName:(NSString *)aName object:(id)anObject cancellableOperation:(id<GtCancellableOperation>) operation
{
	return [NSNotification notificationWithName:aName object:anObject userInfo:[NSDictionary dictionaryWithObject:operation forKey:NSNotificationCancellableOperationKey]];
}

- (id<GtCancellableOperation>) cancellableOperation
{
	return [self.userInfo objectForKey:NSNotificationCancellableOperationKey];
}


@end

//
//	NSNotification+GtExtras.h
//	FishLamp
//
//	Created by Mike Fullerton on 1/23/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtCancellableOperation.h"

extern NSString* const NSNotificationCancellableOperationKey;

@interface NSNotification (GtExtras)

+ (id)notificationWithName:(NSString *)aName object:(id)anObject cancellableOperation:(id<GtCancellableOperation>) operation;

- (id<GtCancellableOperation>) cancellableOperation;


@end

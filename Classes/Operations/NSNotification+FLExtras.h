//
//	NSNotification+FLExtras.h
//	FishLamp
//
//	Created by Mike Fullerton on 1/23/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCocoa.h"

#import "FLCancellableOperation.h"

extern NSString* const NSNotificationCancellableOperationKey;

@interface NSNotification (FLExtras)

+ (id)notificationWithName:(NSString *)aName object:(id)anObject cancellableOperation:(id<FLCancellableOperation>) operation;

- (id<FLCancellableOperation>) cancellableOperation;


@end

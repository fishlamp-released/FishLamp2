//
//	GtMobileNotificationDisplayManager.m
//	FishLampMobileLib
//
//	Created by Mike Fullerton on 9/23/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtMobileNotificationDisplayManager.h"
#import "GtActionContext.h"
#import "GtUserNotificationView.h"

@implementation GtMobileNotificationDisplayManager

- (void) addNotification:(UIView<GtDisplayedNotification>*) notification
{
	UIView* superview = notification.actionContext.contextView;
	if(superview && notification)
	{
		[superview addSubview:notification];
	}
}

- (id<GtDisplayedNotification>) createNotificationWithType:(GtDisplayedNotificationType) type
{
	return GtReturnAutoreleased([[GtUserNotificationView alloc] initWithType:type]);
}

@end

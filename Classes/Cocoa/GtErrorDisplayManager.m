//
//	GtErrorDisplayManager.m
//	ZenApi1.4
//
//	Created by Mike Fullerton on 9/23/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtErrorDisplayManager.h"


@implementation GtNotificationDisplayManager

static GtNotificationDisplayManager* s_manager = nil;

- (void) showNotification:(id<GtDisplayedNotification>) notification
{
}

+ (void) setDefaultDisplayManager:(GtNotificationDisplayManager*) manager
{
	s_manager = GtRetain(manager);
}

+ (GtNotificationDisplayManager*) defaultDisplayManager
{
	return s_manager;
}

- (id<GtDisplayedNotification>) createNotificationWithType:(GtDisplayedNotificationType) type
{
	return nil;
}

- (void) showProgress:(id<GtProgressProtocol>) progress
{
}

- (id) defaultViewController
{
	return nil;
}

@end


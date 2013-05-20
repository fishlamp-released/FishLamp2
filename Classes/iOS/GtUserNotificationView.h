//
//	GtUserNotificationView.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/26/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtNotificationView.h"
#import "GtActionDescription.h"
#import "GtErrorDisplayManager.h"
#import "GtFunctor.h"
#import "GtApplication.h"
#import "GtAutoLayoutViewController.h"
@class GtViewController;

@protocol GtErrorDescriber;

@interface GtUserNotificationView : GtNotificationView<GtDisplayedNotification, GtEventInterceptor> {
	struct { 
		GtDisplayedNotificationType notificationType:4;
		unsigned int autoDismiss:1;
	} m_userNotificationFlags;
	
	NSError* m_error;
	GtActionContext* m_actionContext;
}

- (id) initAsWarningNotification;
- (id) initAsInfoNotification;
- (id) initAsErrorNotification;
- (id) initWithType:(GtDisplayedNotificationType) type;

@property (readonly, assign, nonatomic) BOOL isInfoNotification;
@property (readonly, assign, nonatomic) BOOL isWarningNotification;
@property (readonly, assign, nonatomic) BOOL isErrorNotification;

@property (readwrite, assign, nonatomic) BOOL autoDismiss;

@property (readwrite, assign, nonatomic) GtDisplayedNotificationType notificationType;

- (BOOL) isEqualTo:(GtUserNotificationView*) anotherNotfication;

- (void) setTextWithError:(NSError*) error;


@end


@interface GtUserNotificationViewController : GtNotificationViewController 
@property (readwrite, assign, nonatomic) BOOL autoDismiss;
@property (readonly, strong, nonatomic) GtUserNotificationView* userNotificationView;

- (id) initWithUserNotificationView:(GtUserNotificationView*) view;
+ (id) userNotificationViewController:(GtUserNotificationView*) view;

+ (GtUserNotificationViewController*) currentViewController;

+ (void) hideCurrentView;

@end
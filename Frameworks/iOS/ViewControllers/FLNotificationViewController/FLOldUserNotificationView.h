//
//	FLOldUserNotificationView.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/26/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLOldNotificationView.h"
#import "FLActionDescription.h"
#import "FLFunctor.h"
#import "FLApplication.h"
#import "FLOperationContext.h"

@class FLViewController;

@protocol FLErrorDescriber;

@interface FLOldUserNotificationView : FLOldNotificationView<FLApplicationEventInterceptor> {
	struct { 
//		FLDisplayedNotificationType notificationType:4;
		unsigned int autoDismiss:1;
	} _userNotificationFlags;
	
	NSError* _error;
	FLOperationContext* _operationContext;
}

- (id) initAsWarningNotification;
- (id) initAsInfoNotification;
- (id) initAsErrorNotification;
//- (id) initWithType:(FLDisplayedNotificationType) type;

@property (readonly, assign, nonatomic) BOOL isInfoNotification;
@property (readonly, assign, nonatomic) BOOL isWarningNotification;
@property (readonly, assign, nonatomic) BOOL isErrorNotification;
@property (readwrite, retain, nonatomic) NSError* error;
@property (readwrite, retain, nonatomic) FLOperationContext* actionContext;

@property (readwrite, assign, nonatomic) BOOL autoDismiss;

//@property (readwrite, assign, nonatomic) FLDisplayedNotificationType notificationType;

+ (FLOldUserNotificationView*) currentView;

+ (void) hideCurrentView;

- (BOOL) isEqualTo:(FLOldUserNotificationView*) anotherNotfication;

- (void) setTextWithError:(NSError*) error;

- (void) showDeferredNotification:(UIViewController*) viewControllerOrNil; //show view when parent view controller of view controller becomes visible. If viewControllerOrNil is nil, it will use global notification host.

- (void) showNotification;
- (void) hideNotification;
@end

@interface FLDeferUserNotificationShow : FLFunctor {
}

+ (FLDeferUserNotificationShow*) deferUserNotificationShow:(FLOldUserNotificationView*) view;

@end

//
//	GtErrorDisplayManager.h
//	ZenApi1.4
//
//	Created by Mike Fullerton on 9/23/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

@class GtActionContext;

#import "GtProgressProtocol.h"
#import "GtErrorDescription.h"

@class GtNotificationViewController;
@class GtProgressViewController;

typedef enum {
	GtDisplayedNotificationTypeInfo,
	GtDisplayedNotificationTypeWarning,
	GtDisplayedNotificationTypeError
} GtDisplayedNotificationType;

@protocol GtDisplayedNotification <GtErrorDescription>
@property (readonly, assign, nonatomic) BOOL isInfoNotification;
@property (readonly, assign, nonatomic) BOOL isWarningNotification;
@property (readonly, assign, nonatomic) BOOL isErrorNotification;
@property (readwrite, assign, nonatomic) GtDisplayedNotificationType notificationType;
@property (readwrite, retain, nonatomic) GtActionContext* actionContext;
- (void) showNotification;
- (void) hideNotification;
@end


@protocol GtNotificationDisplayManager <NSObject>
- (void) showNotification:(GtNotificationViewController*) notification;
- (GtNotificationViewController*) createNotificationWithType:(GtDisplayedNotificationType) type;

- (id) defaultViewController;

- (void) showProgress:(GtProgressViewController*) progress;
@end

@interface GtNotificationDisplayManager : NSObject<GtNotificationDisplayManager> {

}

+ (void) setDefaultDisplayManager:(id<GtNotificationDisplayManager>) manager;
+ (id<GtNotificationDisplayManager>) defaultDisplayManager;

@end

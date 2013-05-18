//
//  GtUserNotificationView.h
//  MyZen
//
//  Created by Mike Fullerton on 12/26/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtNotificationView.h"


#define GtLowErrorFormatterPriority     0
#define GtHighErrorFormatterPriority    10

typedef enum
{
    GtUserNotificationViewInfoType,
    GtUserNotificationViewWarningType,
    GtUserNotificationViewErrorType
} GtUserNotificationViewType;

@protocol GtUserNotificationErrorFormatterProtocol;

@interface GtUserNotificationView : GtNotificationView {
	NSString* m_suggestedRemedy;
    
	struct { 
		unsigned int viewType:4;
		unsigned int willTryAgain:1;
	} m_userNotificationFlags;
}

- (id) initAsWarningNotification;
- (id) initAsInfoNotification;
- (id) initAsErrorNotification;

@property (readonly, assign, nonatomic) BOOL isInfoNotification;
@property (readonly, assign, nonatomic) BOOL isWarningNotification;
@property (readonly, assign, nonatomic) BOOL isErrorNotification;

@property (readonly, assign, nonatomic) GtUserNotificationViewType viewType;

@property (readwrite, assign, nonatomic) BOOL willTryAgain;

- (void) setTextWithError:(NSError*) error
                    title:(NSString*) title;
                    
- (void) setTextWithErrorUsingFormatters:(NSError*) error;

- (void) setTextWithErrorUsingFormatters:(NSError*) error
                         suggestedRemedy:(NSString*) suggestedRemedy;

- (void) addSuggestedRemedyToText;

+ (GtUserNotificationView*) currentView;
+ (void) hideCurrentView;

+ (void) addErrorFormatter:(id<GtUserNotificationErrorFormatterProtocol>) handler;

@end

@protocol GtUserNotificationErrorFormatterProtocol <NSObject>

- (BOOL) formatErrorForDisplay:(NSError*) error 
               forNotification:(GtUserNotificationView*) notification;
- (NSString*) domain;
- (NSUInteger) priority; // built in formatters have priority of GtLowErrorFormatterPriority

@end
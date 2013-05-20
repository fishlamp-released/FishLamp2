//
//  GtActionErrorHandler.h
//  FishLamp
//
//  Created by Mike Fullerton on 12/20/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtReachability.h"
#import "GtUserNotificationView.h"
#import "GtWeakReference.h"

@class GtAction;

@interface GtActionErrorHandler : NSObject {
    NSMutableArray* m_networkOfflineQueuedActions;
    NSMutableArray* m_retryAlertQueue;
	id m_delegate;
    GtWeakReference* m_warningView;
}

GtSingletonProperty(GtActionErrorHandler);

@property (readwrite, assign, nonatomic) id delegate;

- (BOOL) attemptToRetryOnNetworkError:(GtAction*) action;

- (void) reportError:(GtAction*) action;
                  
@end

@protocol GtActionErrorHandlerDelegate <NSObject>

- (BOOL) actionErrorHandler:(GtActionErrorHandler*) handler
	 attemptToRetryOnNetworkError:(GtAction*) action
	 reachability:(GtReachability*) reachability;	 

- (BOOL) actionErrorHandler:(GtActionErrorHandler*) handler
	 reportErrorForAction:action
	 userNotificationView:(GtUserNotificationView*) view;

@end
//
//  FLNotificationViewController.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 3/23/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLNotificationViewController.h"
#import "FLNotificationView.h"

@interface FLNotificationViewController ()

@end

@implementation FLNotificationViewController

- (UIView*) createView {
    FLNotificationView* view = [FLNotificationView viewWithFrame:CGRectMake(0,0, 128,80)];
    return view;
}

- (id) init {
    self = [super init];
    if(self) {
        self.contentMode = FLRectLayoutMake(FLRectLayoutHorizontalFill, FLRectLayoutVerticalBottom);
    }
    return self;
}

- (id) _view {
    return self.view;
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    [self._view setTitle:self.title];
}

- (void) setTitle:(NSString*) title {
    [super setTitle:title];
    [self._view setTitle:title];
    [self updateViewSizeAndPosition];
}

- (void) sizeToFitInBounds:(CGRect) bounds {
    self.view.frame = FLRectSetSizeWithSize(self.view.frame, [self.view sizeThatFits:bounds.size]);
}

@end

@implementation FLActionErrorNotificationHandler

FLSynthesizeSingleton(FLActionErrorNotificationHandler);

- (void) actionShouldDisplayError:(FLAction*) action
{
/*
			id<FLDisplayedNotification> view = [[FLNotificationDisplayManager defaultDisplayManager] createNotificationWithType:FLDisplayedNotificationTypeError];
			view.actionContext = self.context;
			view.title = self.actionDescription.failureText;
			view.error = self.error;
				
			NSString* description = [[FLErrorDescriberManager instance] describeError:self.error];
			if(description)
			{	
				if(FLStringIsNotEmpty(description))
				{
					view.description = description;
				}
			}
			else
			{
				view.description = [NSString stringWithFormat:NSLocalizedString(@"An unexpected error occured.\n\n%@", nil), self.error.localizedDescription];
			}
				
			[view showNotification];
*/

}

- (void) hideNotification:(id) notification
{
}

- (void) actionDisplayServerNotRespondingMessage:(FLAction*) action 
                                        timeSpan:(NSTimeInterval) timeSpan 
                                     description:(NSString*) description
{
//    NSString* title = [NSString stringWithFormat:(NSLocalizedString(@"The server hasn't responded for %.0f seconds.", nil)), idleTimeSpan];
//
//    id<FLDisplayedNotification> notification = self.errorNotificationForUser;
//    if(!notification)
//    {
//        notification = [[FLNotificationDisplayManager defaultDisplayManager] createNotificationWithType:FLDisplayedNotificationTypeWarning];
//        
//        notification.title = title;
//        if(FLStringIsNotEmpty(operation.activityTimerExplanation))
//        {
//            notification.description = operation.activityTimerExplanation;
//        }
//        
//        self.errorNotificationForUser = notification;
//        [notification showNotification];
//    }
//    else
//    {
//        notification.title = title;
//    }
}

@end

/*
- (void) showNotification:(FLOldUserNotificationView*) notification
{
	FLAutorelease(FLReturnRetain(notification));
	FLViewController* controller = (FLViewController*) [self defaultViewController];
#if VIEW_AUTOLAYOUT
	notification.viewDelegate = controller;
#endif    
	[controller.view addSubview:notification];
}

//- (void) showProgress:(id <FLLegacyProgressProtocol>)progress
//{
//	FLViewController* controller = (FLViewController*) [self defaultViewController];
//#if VIEW_AUTOLAYOUT
////	((FLWidgetView*)progress).viewDelegate = controller;
//#endif
//	[progress showProgressInViewController:controller];
//}

- (id<FLDisplayedNotification>) createNotificationWithType:(FLDisplayedNotificationType) type
{
	return FLAutorelease([[FLOldUserNotificationView alloc] initWithType:type]);
}
*/
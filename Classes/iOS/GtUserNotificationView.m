//
//	GtUserNotificationView.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/26/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtUserNotificationView.h"
#import "NSFileManager+GtExtras.h"
#import "GtSoapError.h"
#import "UIImage+GtColorize.h"
#import "GtErrorDisplayManager.h"
#import "GtViewController.h"
#import "GtMobileNotificationDisplayManager.h"

static GtWeakReference* s_currentView = nil;

@implementation GtUserNotificationView

GtSynthesizeStructProperty(autoDismiss, setAutoDismiss, BOOL, m_userNotificationFlags);
GtSynthesizeStructProperty(notificationType, setNotificationType, GtDisplayedNotificationType, m_userNotificationFlags);
@synthesize error = m_error;
@synthesize actionContext = m_actionContext;
//@dynamic weakReferences;

+ (UIColor*) grayGlossyButtonColor
{
	RETURN_RGB_COLOR(235, 235, 237);
}

+ (UIColor*) redGlossyButtonColor
{
	RETURN_RGB_COLOR(160, 1, 20);
}

+ (UIColor*) greenGlossyButtonColor
{
	RETURN_RGB_COLOR(24, 157, 22);
}

+ (UIColor*) yellowGlossyButtonColor
{
	RETURN_RGB_COLOR(240, 191, 34);
}

+ (UIColor*) blackGlossyButtonColor
{
	return [UIColor gray10Color];
}

+ (void) setCurrentView:(GtUserNotificationView*) view
{
	if(view.autoDismiss)
	{
		if(!s_currentView)
		{
			s_currentView = [[GtWeakReference alloc] init];
		}
		else if(s_currentView.object && s_currentView.object != view)
		{
			[s_currentView.object hideNotification];
		}
		s_currentView.object = view;
	}
}

+ (void) hideCurrentView
{
	if(s_currentView && s_currentView.object)
	{
		[s_currentView.object hideNotification];
		s_currentView.object = nil;
	}
}

+ (GtUserNotificationView*) currentView
{
	return s_currentView != nil ? s_currentView.object : nil;
} 

- (id) init
{
	if((self = [super init]))
	{
		self.dismissStyle = GtNotificationViewDismissStyleTapAnywhere;
		self.padding = 10.0f;
		self.autoDismiss = YES;
        
        [[GtApplication sharedApplication] addEventInterceptor:self];
	}

	return self;
}

- (void) dealloc
{
    [[GtApplication sharedApplication] removeEventInterceptor:self];
	GtRelease(m_error);
	GtSuperDealloc();
}

- (void) setIcon:(UIImage*) image
{
	UIImageView* iconView = [[UIImageView alloc] initWithImage:image];
	iconView.backgroundColor = [UIColor clearColor];
	iconView.contentMode = UIViewContentModeScaleAspectFit;
	iconView.frame = GtRectSetSize(iconView.frame, 20,20);
	
	self.iconView = iconView;
	GtReleaseWithNil(iconView);
}

- (void) setIconWithColor:(UIImage*) image color:(UIColor*) color blendMode:(CGBlendMode) blendMode
{
	image = [image colorizeImage:color blendMode:blendMode];

	[self setIcon:image];
}

- (id) initAsWarningNotification
{
	if((self = [self init]))
	{
		[self setIconWithColor:[UIImage imageNamed:@"warning.png"] color:[GtUserNotificationView yellowGlossyButtonColor] blendMode:kCGBlendModeOverlay];
		m_userNotificationFlags.notificationType = GtDisplayedNotificationTypeWarning;
	}
	return self;
}

- (id) initAsInfoNotification
{
	if((self = [self init]))
	{
		[self setIconWithColor:[UIImage imageNamed:@"info-white.png"] color:[UIColor whiteColor] blendMode:kCGBlendModeOverlay];
		m_userNotificationFlags.notificationType = GtDisplayedNotificationTypeInfo;
		self.shouldAutoCloseAfterDelay = YES;
	}
	return self;
}

- (id) initAsErrorNotification
{
	if((self = [self init]))
	{
		[self setIconWithColor:[UIImage imageNamed:@"warning.png"] color:[GtUserNotificationView redGlossyButtonColor] blendMode:kCGBlendModeOverlay];
		
		m_userNotificationFlags.notificationType = GtDisplayedNotificationTypeError;
	}
	return self;
}

- (id) initWithType:(GtDisplayedNotificationType) type
{
	switch(type)
	{
		case GtDisplayedNotificationTypeInfo:
			return [self initAsInfoNotification];
			break;
		case GtDisplayedNotificationTypeWarning:
			return [self initAsWarningNotification];
			break;
		case GtDisplayedNotificationTypeError:
			return [self initAsErrorNotification];
			break;
	}
	
	return nil;
}

- (BOOL) isInfoNotification
{
	return self.notificationType == GtDisplayedNotificationTypeInfo;
}

- (BOOL) isWarningNotification
{
	return self.notificationType == GtDisplayedNotificationTypeWarning;
}

- (BOOL) isErrorNotification
{
	return self.notificationType == GtDisplayedNotificationTypeError;
	
}

- (void)didMoveToSuperview
{
	[super didMoveToSuperview];
	if(self.superview)
	{
		[GtUserNotificationView setCurrentView:self];
	}
}

- (BOOL) isEqualTo:(GtUserNotificationView*) anotherView
{
	return	anotherView.notificationType == self.notificationType &&
			[anotherView.title isEqualToString:self.title] &&
			[anotherView.text isEqualToString:self.text];

}

- (BOOL) didInterceptEvent:(UIEvent*) event
{
    if(event.type == UIEventTypeTouches)
    {
        NSSet* touches = event.allTouches;
        UITouch *touch = touches.anyObject;
        if(touch && touch.window == self.window)
        {
            UIView* touchedView = touch.view;
            
            if( touchedView &&
                (touchedView != self) &&
                (![touchedView isDescendantOfView:self]))
            {
            //	  if(([NSDate timeIntervalSinceReferenceDate] - myCurrentView.shownTimestamp) > 1)
                {
                    [self hideNotification];
                }
            }
        }
    }
	
    return NO;
}

- (UIFont*) textViewFont
{
	return [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
}

- (NSString*) title
{
	return [super title];
}

- (void) setTitle:(NSString*) title
{
	[super setTitle:title];
}

- (NSString*) description
{	
	return self.text;
}

- (void) setDescription:(NSString*) description
{
	self.text = description;
}

//- (NSString*) displayError
//{
//	  return [super errorCode];
//}

- (void) setTextWithError:(NSError*) error
{
	NSString* localizedDescription = [error.userInfo objectForKey:NSLocalizedDescriptionKey];
	if(GtStringIsNotEmpty(localizedDescription))
	{
		self.text = localizedDescription;
	}
	else
	{
		self.text = NSLocalizedString(@"An error occurred.", nil);
	}
}

//- (void) showDeferredNotification:(GtViewController*) viewControllerOrNil
//{
//	if(!viewControllerOrNil)
//	{
//		viewControllerOrNil = [[GtMobileNotificationDisplayManager defaultDisplayManager] defaultViewController];
//	}
//	
//	GtAssertNotNil(viewControllerOrNil);
//
//	GtViewController* controller = (GtViewController*) [viewControllerOrNil.navigationController parentControllerForController:viewControllerOrNil];
//	GtAssertNotNil(controller);
//	
//	[controller addDidAppearCallback:[GtDeferUserNotificationShow deferUserNotificationShow:self]];
//}

- (void) showNotification
{
}

- (void) hideNotification
{
	[super hideNotification];
}
		

@end

@implementation GtUserNotificationViewController

- (BOOL) autoDismiss {
    return self.userNotificationView.autoDismiss;
}

- (void) setAutoDismiss:(BOOL) autoDismiss {
    self.userNotificationView.autoDismiss = autoDismiss;
}

- (id) initWithUserNotificationView:(GtUserNotificationView*) view {
	self.themeAction = @selector(applyThemeToUserNotificationViewController:);

    return [super initWithView:view];
}
+ (id) userNotificationViewController:(GtUserNotificationView*) view {
    return [[[[self class] alloc] init] autorelease];
}

- (GtUserNotificationView*) userNotificationView {
    return (GtUserNotificationView*) self.view;
}

- (void) hideNotification
{
    [self.userNotificationView hideNotification];
}

- (void) showNotification
{
	if([NSThread isMainThread])
	{
		[[GtNotificationDisplayManager defaultDisplayManager] showNotification:self];
	}
	else
	{
		[self performSelectorOnMainThread:@selector(showNotification) withObject:nil waitUntilDone:NO];
	}
}

// FIXME - pull implementation of this from view into viewcontroller;

+ (GtUserNotificationViewController*) currentViewController {
    
    return nil;
}

+ (void) hideCurrentView {

}



@end


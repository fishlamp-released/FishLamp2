//
//	FLOldUserNotificationView.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/26/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLOldUserNotificationView.h"
#import "NSFileManager+FLExtras.h"
#import "FLSoapError.h"
#import "UIImage+Colorize.h"
#import "FLViewController.h"

static FLWeakReference* s_currentView = nil;

@implementation FLOldUserNotificationView

FLSynthesizeStructProperty(autoDismiss, setAutoDismiss, BOOL, _userNotificationFlags);
@synthesize error = _error;
@synthesize actionContext = _operationContext;
//@dynamic weakReferences;


+ (void) setCurrentView:(FLOldUserNotificationView*) view
{
	if(view.autoDismiss)
	{
		if(!s_currentView)
		{
			s_currentView = [[FLWeakReference alloc] init];
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

+ (FLOldUserNotificationView*) currentView
{
	return s_currentView != nil ? s_currentView.object : nil;
} 

- (void) applyTheme:(FLTheme*) theme {
}


- (id) init
{
	if((self = [super init]))
	{
		self.wantsApplyTheme = YES;

		self.dismissStyle = FLOldNotificationViewDismissStyleTapAnywhere;
		self.padding = 10.0f;
		self.autoDismiss = YES;
        
        [[FLApplication sharedApplication] addEventInterceptor:self];
	}

	return self;
}

- (void) dealloc
{
    [[FLApplication sharedApplication] removeEventInterceptor:self];
	FLRelease(_error);
	FLSuperDealloc();
}

- (void) setIcon:(UIImage*) image
{
	UIImageView* iconView = [[UIImageView alloc] initWithImage:image];
	iconView.backgroundColor = [UIColor clearColor];
	iconView.contentMode = UIViewContentModeScaleAspectFit;
	iconView.frame = FLRectSetSize(iconView.frame, 20,20);
	
	self.iconView = iconView;
	FLReleaseWithNil(iconView);
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
		[self setIconWithColor:[UIImage imageNamed:@"warning.png"] color:[UIColor yellowGlossyButtonColor] blendMode:kCGBlendModeOverlay];
//		_userNotificationFlags.notificationType = FLDisplayedNotificationTypeWarning;
	}
	return self;
}

- (id) initAsInfoNotification
{
	if((self = [self init]))
	{
		[self setIconWithColor:[UIImage imageNamed:@"info-white.png"] color:[UIColor whiteColor] blendMode:kCGBlendModeOverlay];
//		_userNotificationFlags.notificationType = FLDisplayedNotificationTypeInfo;
		self.shouldAutoCloseAfterDelay = YES;
	}
	return self;
}

- (id) initAsErrorNotification
{
	if((self = [self init]))
	{
		[self setIconWithColor:[UIImage imageNamed:@"warning.png"] color:[UIColor redGlossyButtonColor] blendMode:kCGBlendModeOverlay];
		
//		_userNotificationFlags.notificationType = FLDisplayedNotificationTypeError;
	}
	return self;
}

//- (id) initWithType:(FLDisplayedNotificationType) type
//{
//	switch(type)
//	{
//		case FLDisplayedNotificationTypeInfo:
//			return [self initAsInfoNotification];
//			break;
//		case FLDisplayedNotificationTypeWarning:
//			return [self initAsWarningNotification];
//			break;
//		case FLDisplayedNotificationTypeError:
//			return [self initAsErrorNotification];
//			break;
//	}
//	
//	return nil;
//}

- (BOOL) isInfoNotification
{
return NO;
}

- (BOOL) isWarningNotification
{
return NO;
}

- (BOOL) isErrorNotification
{
return NO;
//	return self.notificationType == FLDisplayedNotificationTypeError;
	
}

- (void)didMoveToSuperview
{
	[super didMoveToSuperview];
	if(self.superview)
	{
		[FLOldUserNotificationView setCurrentView:self];
	}
}

- (BOOL) isEqualTo:(FLOldUserNotificationView*) anotherView
{
	return	//anotherView.notificationType == self.notificationType &&
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
	if(FLStringIsNotEmpty(localizedDescription))
	{
		self.text = localizedDescription;
	}
	else
	{
		self.text = NSLocalizedString(@"An error occurred.", nil);
	}

}

- (void) showNotification
{
//	if([NSThread isMainThread])
//	{
//		[[FLNotificationDisplayManager defaultDisplayManager] showNotification:self];
//	}
//	else
//	{
//		[self performSelectorOnMainThread:@selector(showNotification) withObject:nil waitUntilDone:NO];
//	}
}

- (void) showDeferredNotification:(UIViewController*) viewControllerOrNil
{
//	if(!viewControllerOrNil)
//	{
//		viewControllerOrNil = [[FLMobileNotificationDisplayManager defaultDisplayManager] defaultViewController];
//	}
//	
//	FLAssertIsNotNil(viewControllerOrNil);
//
//	FLViewController* controller = (FLViewController*) [viewControllerOrNil.navigationController parentControllerForController:viewControllerOrNil];
//	FLAssertIsNotNil(controller);
//	
//	[controller addDidAppearCallback:[FLDeferUserNotificationShow deferUserNotificationShow:self]];
}

- (void) hideNotification
{
	[super hideNotification];
}
		

@end

@implementation FLDeferUserNotificationShow

- (void) doPerformCallback:(id) sender
{
	[self.userInfo showNotification];
}

+ (FLDeferUserNotificationShow*) deferUserNotificationShow:(FLOldUserNotificationView*) view
{
   FLDeferUserNotificationShow* show = FLAutorelease([[FLDeferUserNotificationShow alloc] init]);
   show.userInfo = view;
   return show; 
}

@end

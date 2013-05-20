//
//	GtKeyboardManager.m
//	FishLamp
//
//	Created by Mike Fullerton on 4/17/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtKeyboardManager.h"


@implementation GtKeyboardManager

NSString *const GtKeyboardDidHideNotification = @"GtKeyboardDidHideNotification";
NSString *const GtKeyboardWillShowNotification = @"GtKeyboardWillShowNotification";
NSString *const GtKeyboardDidShowNotification = @"GtKeyboardDidShowNotification";; 
NSString *const GtKeyboardWillHideNotification = @"GtKeyboardWillHideNotification";; 

@synthesize isShowing = m_showing;

GtSynthesizeSingleton(GtKeyboardManager);

- (CGRect) keyboardRectForView:(UIView*) view
{
	return [view convertRect:m_keyboardRect fromView:view.window];
}

- (void) _checkForHiddenKeyboard
{
	if(!m_showing)
	{
		[[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:GtKeyboardDidHideNotification object:nil
			userInfo:nil]];
	}
}
- (void) _checkForVisibleKeyboard
{
	if(m_showing)
	{
		[[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:GtKeyboardDidShowNotification object:nil
			userInfo:nil]];
	}
}

- (void) keyboardDidHide:(id) sender
{
	m_showing = NO;
	[self performSelector:@selector(_checkForHiddenKeyboard) withObject:nil afterDelay:0.25];
}


- (void) keyboardDidShow:(id)sender
{
	m_showing = YES;
	m_keyboardRect = [[[sender userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
	GtAssert(!CGRectEqualToRect(m_keyboardRect, CGRectZero), @"empty keyboard rect");
	[self performSelector:@selector(_checkForVisibleKeyboard) withObject:nil afterDelay:0.25];
}

- (void) keyboardWillShow:(id)sender
{
	m_keyboardRect = [[[sender userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
	GtAssert(!CGRectEqualToRect(m_keyboardRect, CGRectZero), @"empty keyboard rect");
	[[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:GtKeyboardWillShowNotification object:nil
			userInfo:nil]];
}

- (void) keyboardWillHide:(id)sender
{
	[[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:GtKeyboardWillHideNotification object:nil
			userInfo:nil]];
}

- (id) init
{
	if((self = [super init]))
	{
	}
	
	return self;
}

- (void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	
	GtSuperDealloc();
}

- (void) startWatchingKeyboard
{
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name: UIKeyboardDidShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name: UIKeyboardWillShowNotification object:nil];

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name: UIKeyboardDidHideNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name: UIKeyboardWillHideNotification object:nil];
}

@end

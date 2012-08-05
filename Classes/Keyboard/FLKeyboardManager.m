//
//	FLKeyboardManager.m
//	FishLamp
//
//	Created by Mike Fullerton on 4/17/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLKeyboardManager.h"


@implementation FLKeyboardManager

NSString *const FLKeyboardDidHideNotification = @"FLKeyboardDidHideNotification";
NSString *const FLKeyboardWillShowNotification = @"FLKeyboardWillShowNotification";
NSString *const FLKeyboardDidShowNotification = @"FLKeyboardDidShowNotification";; 
NSString *const FLKeyboardWillHideNotification = @"FLKeyboardWillHideNotification";; 

@synthesize isShowing = _showing;

FLSynthesizeSingleton(FLKeyboardManager);

- (CGRect) keyboardRectForView:(UIView*) view {
	return [view convertRect:_keyboardRect fromView:view.window];
}

- (void) _checkForHiddenKeyboard {
	if(!_showing) {
		[[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:FLKeyboardDidHideNotification object:nil
			userInfo:nil]];
	}
}
- (void) _checkForVisibleKeyboard {
	if(_showing) {
		[[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:FLKeyboardDidShowNotification object:nil
			userInfo:nil]];
	}
}

- (void) keyboardDidHide:(id) sender {
	_showing = NO;
	[self performSelector:@selector(_checkForHiddenKeyboard) withObject:nil afterDelay:0.25];
}


- (void) keyboardDidShow:(id)sender {
	_showing = YES;
	_keyboardRect = [[[sender userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
	FLAssert(!CGRectEqualToRect(_keyboardRect, CGRectZero), @"empty keyboard rect");
	[self performSelector:@selector(_checkForVisibleKeyboard) withObject:nil afterDelay:0.25];
}

- (void) keyboardWillShow:(id)sender {
	_keyboardRect = [[[sender userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
	FLAssert(!CGRectEqualToRect(_keyboardRect, CGRectZero), @"empty keyboard rect");
	[[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:FLKeyboardWillShowNotification object:nil
			userInfo:nil]];
}

- (void) keyboardWillHide:(id)sender {
	[[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:FLKeyboardWillHideNotification object:nil
			userInfo:nil]];
}

- (id) init {
	if((self = [super init])) {
	}
	
	return self;
}

- (void) dealloc{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	FLSuperDealloc();
}

- (void) startWatchingKeyboard {
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name: UIKeyboardDidShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name: UIKeyboardWillShowNotification object:nil];

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name: UIKeyboardDidHideNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name: UIKeyboardWillHideNotification object:nil];
}

@end

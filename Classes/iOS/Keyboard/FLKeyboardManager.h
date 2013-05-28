//
//	FLKeyboardManager.h
//	FishLamp
//
//	Created by Mike Fullerton on 4/17/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

extern NSString *const FLKeyboardWillShowNotification;
extern NSString *const FLKeyboardWillHideNotification; 

extern NSString *const FLKeyboardDidShowNotification; // Broadcast first time.
extern NSString *const FLKeyboardDidHideNotification; // This actually gets fired when the keybaord is actually gone, unlike the sdk event.

@interface FLKeyboardManager : NSObject {
@private
	CGRect _keyboardRect;
	BOOL _showing;
}

- (void) startWatchingKeyboard;

@property (readonly, assign, nonatomic) BOOL isShowing;
- (CGRect) keyboardRectForView:(UIView*) view;

FLSingletonProperty(FLKeyboardManager);

@end

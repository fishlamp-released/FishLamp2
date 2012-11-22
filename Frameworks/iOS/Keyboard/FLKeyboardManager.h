//
//	FLKeyboardManager.h
//	FishLamp
//
//	Created by Mike Fullerton on 4/17/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const FLKeyboardWillShowNotification;
extern NSString *const FLKeyboardWillHideNotification; 

extern NSString *const FLKeyboardDidShowNotification; // Broadcast first time.
extern NSString *const FLKeyboardDidHideNotification; // This actually gets fired when the keybaord is actually gone, unlike the sdk event.

@interface FLKeyboardManager : NSObject {
@private
	FLRect _keyboardRect;
	BOOL _showing;
}

- (void) startWatchingKeyboard;

@property (readonly, assign, nonatomic) BOOL isShowing;
- (FLRect) keyboardRectForView:(UIView*) view;

FLSingletonProperty(FLKeyboardManager);

@end

//
//	GtKeyboardManager.h
//	FishLamp
//
//	Created by Mike Fullerton on 4/17/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

extern NSString *const GtKeyboardWillShowNotification;
extern NSString *const GtKeyboardWillHideNotification; 

extern NSString *const GtKeyboardDidShowNotification; // Broadcast first time.
extern NSString *const GtKeyboardDidHideNotification; // This actually gets fired when the keybaord is actually gone, unlike the sdk event.

@interface GtKeyboardManager : NSObject {
@private
	CGRect m_keyboardRect;
	BOOL m_showing;
}

- (void) startWatchingKeyboard;

@property (readonly, assign, nonatomic) BOOL isShowing;
- (CGRect) keyboardRectForView:(UIView*) view;

GtSingletonProperty(GtKeyboardManager);

@end

//
//	FLAlert.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/24/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCallbackObject.h"
#import "FLAlertButtonCallback.h"

@interface FLLegacyAlertView : UIAlertView<UIAlertViewDelegate> {
@private
	FLCallbackObject* _clickedCallback;
	NSInteger _clickedButton;
	NSMutableArray* _items;
	id _userInfo;
}
@property (readwrite, retain, nonatomic) id userInfo;
@property (readonly, assign, nonatomic) NSInteger clickedButtonIndex;
@property (readonly, assign, nonatomic) BOOL wasCancelled;

- (void) setDismissedCallback:(id) targetOrObjectContainer action:(SEL) action; 

- (id)initWithTitle:(NSString *)title 
							message:(NSString *)message	 
							cancelButtonTitle:(NSString *)cancelButtonTitle 
							otherButtonTitles:(NSString *)otherButtonTitles, ...;

- (id)initWithTitle:(NSString *)title 
							message:(NSString *)message	 
							cancelButtonCallback:(FLAlertButtonCallback *)cancelButtonCallback 
							otherButtonCallbacks:(FLAlertButtonCallback *)otherButtonCallbacks, ...;




@end

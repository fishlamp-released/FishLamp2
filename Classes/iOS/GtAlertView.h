//
//	GtAlertView.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/24/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtCallbackObject.h"
#import "GtAlertButtonCallback.h"

@interface GtAlertView : UIAlertView<UIAlertViewDelegate> {
@private
	GtCallbackObject* m_clickedCallback;
	NSInteger m_clickedButton;
	NSMutableArray* m_items;
	id m_userInfo;
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
							cancelButtonCallback:(GtAlertButtonCallback *)cancelButtonCallback 
							otherButtonCallbacks:(GtAlertButtonCallback *)otherButtonCallbacks, ...;




@end

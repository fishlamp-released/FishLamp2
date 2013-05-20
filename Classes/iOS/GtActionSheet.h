//
//	GtActionSheet.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/2/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "GtCallbackObject.h"

#import "GtAlertButtonCallback.h"

@interface GtActionSheet : UIActionSheet<UIActionSheetDelegate> {
@private
	GtCallbackObject* m_clickedCallback;
	NSInteger m_clickedButton;	
	NSMutableArray* m_items;
}

@property (readonly, assign, nonatomic) NSInteger buttonIndex;
@property (readonly, assign, nonatomic) BOOL wasCancelled;

- (void) setDismissedCallback:(id) targetOrObjectContainer action:(SEL) action; 

- (id)initWithTitle:(NSString *)title 
 cancelButtonTitle:(NSString *)cancelButtonTitle 
 destructiveButtonTitle:(NSString *)destructiveButtonTitle 
 otherButtonTitles:(NSString *)otherButtonTitles, ...;

- (id)initWithTitle:(NSString *)title 
cancelButtonCallback:(GtAlertButtonCallback *)cancelButtonCallback 
destructiveButtonCallback:(GtAlertButtonCallback *)destructiveButtonCallback 
otherButtonCallbacks:(GtAlertButtonCallback *)otherButtonCallbacks, ...;


@end

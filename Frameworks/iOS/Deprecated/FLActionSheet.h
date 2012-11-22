//
//	FLActionSheet.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/2/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLCallbackObject.h"

#import "FLAlertButtonCallback.h"

@interface FLActionSheet : UIActionSheet<UIActionSheetDelegate> {
@private
	FLCallbackObject* _clickedCallback;
	NSInteger _clickedButton;	
	NSMutableArray* _items;
}

@property (readonly, assign, nonatomic) NSInteger buttonIndex;
@property (readonly, assign, nonatomic) BOOL wasCancelled;

- (void) setDismissedCallback:(id) targetOrObjectContainer action:(SEL) action; 

- (id)initWithTitle:(NSString *)title 
 cancelButtonTitle:(NSString *)cancelButtonTitle 
 destructiveButtonTitle:(NSString *)destructiveButtonTitle 
 otherButtonTitles:(NSString *)otherButtonTitles, ...;

- (id)initWithTitle:(NSString *)title 
cancelButtonCallback:(FLAlertButtonCallback *)cancelButtonCallback 
destructiveButtonCallback:(FLAlertButtonCallback *)destructiveButtonCallback 
otherButtonCallbacks:(FLAlertButtonCallback *)otherButtonCallbacks, ...;


@end

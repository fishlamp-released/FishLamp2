//
//	FLActionSheet.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/2/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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

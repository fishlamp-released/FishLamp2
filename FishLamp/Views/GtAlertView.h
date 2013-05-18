//
//  GtAlertView.h
//  MyZen
//
//  Created by Mike Fullerton on 12/24/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtSimpleCallback.h"

@interface GtAlertView : UIAlertView<UIAlertViewDelegate> {
@private
	GtSimpleCallback* m_clickedCallback;
	NSInteger m_clickedButton;	
}

@property (readonly, assign, nonatomic) NSInteger clickedButtonIndex;
@property (readonly, assign, nonatomic) BOOL wasCancelled;

- (void) setButtonClickedCallback:(id) target action:(SEL) action; 

- (id)initWithTitle:(NSString *)title message:(NSString *)message  
							cancelButtonTitle:(NSString *)cancelButtonTitle 
							otherButtonTitles:(NSString *)otherButtonTitles, ...;



@end

//
//  GtActionSheet.h
//  MyZen
//
//  Created by Mike Fullerton on 2/2/10.
//  Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GtSimpleCallback.h"

@interface GtActionSheet : UIActionSheet<UIActionSheetDelegate> {
	GtSimpleCallback* m_clickedCallback;
	NSInteger m_clickedButton;	
    UIView* m_rotateView;
    
    struct {
        unsigned int rotateToStatusBarOrientation:1;
    } m_flags;
}

@property (readonly, assign, nonatomic) NSInteger clickedButtonIndex;
@property (readonly, assign, nonatomic) BOOL wasCancelled;

@property (readwrite, assign, nonatomic) BOOL rotateToStatusBarOrientation;

- (void) setButtonClickedCallback:(id) target action:(SEL) action; 

- (id)initWithTitle:(NSString *)title 
  cancelButtonTitle:(NSString *)cancelButtonTitle 
  destructiveButtonTitle:(NSString *)destructiveButtonTitle 
  otherButtonTitles:(NSString *)otherButtonTitles, ...;

+ (BOOL) defaultRotateToStatusBarOrientation;
+ (void) setDefaultRotateToStatusBarOrientation:(BOOL) defaultDoRotate;

@end

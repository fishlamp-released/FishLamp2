//
//	FLCameraViewControllerButtomButtomView.h
//	FishLamp
//
//	Created by Mike Fullerton on 7/31/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLCameraViewControllerBottomButtonView : UIView {
	IBOutlet id m_leftButton;
	IBOutlet id m_rightButton;
	IBOutlet id m_centerButton;
}

@property (readwrite, retain, nonatomic) id leftButton;
@property (readwrite, retain, nonatomic) id centerButton;
@property (readwrite, retain, nonatomic) id rightButton;

- (void) setCommonTraitsForButtons:(UIButton*) button;

@end
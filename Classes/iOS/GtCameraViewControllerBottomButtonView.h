//
//	GtCameraViewControllerButtomButtomView.h
//	FishLamp
//
//	Created by Mike Fullerton on 7/31/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

@interface GtCameraViewControllerBottomButtonView : UIView {
	IBOutlet id m_leftButton;
	IBOutlet id m_rightButton;
	IBOutlet id m_centerButton;
}

@property (readwrite, retain, nonatomic) id leftButton;
@property (readwrite, retain, nonatomic) id centerButton;
@property (readwrite, retain, nonatomic) id rightButton;

- (void) setCommonTraitsForButtons:(UIButton*) button;

@end
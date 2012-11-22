//
//	FLCameraViewControllerButtomButtomView.h
//	FishLamp
//
//	Created by Mike Fullerton on 7/31/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLCameraViewControllerBottomButtonView : UIView {
	IBOutlet id _leftButton;
	IBOutlet id _rightButton;
	IBOutlet id _centerButton;
}

@property (readwrite, retain, nonatomic) id leftButton;
@property (readwrite, retain, nonatomic) id centerButton;
@property (readwrite, retain, nonatomic) id rightButton;

- (void) setCommonTraitsForButtons:(UIButton*) button;

@end
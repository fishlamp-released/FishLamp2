//
//  FLAlertButtonContainerView.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/19/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FLButtonContainerView;

typedef void (^FLButtonContainerViewButtonSetupBlock)(FLButtonContainerView* view, FLButton* button);

@interface FLButtonContainerView : UIView {
@private
    FLButtonContainerViewButtonSetupBlock _onSetupButton;
}

@property (readwrite, copy, nonatomic) FLButtonContainerViewButtonSetupBlock onSetupButton;

- (void) addButton:(FLButton*) button;

@end

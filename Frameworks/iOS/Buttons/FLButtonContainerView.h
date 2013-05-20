//
//  FLAlertButtonContainerView.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/19/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <UIKit/UIKit.h>

#import "FLButton.h"

@class FLButtonContainerView;

typedef void (^FLButtonContainerViewButtonSetupBlock)(FLButtonContainerView* view, FLButton* button);

@interface FLButtonContainerView : UIView {
@private
    FLButtonContainerViewButtonSetupBlock _onSetupButton;
}

@property (readwrite, copy, nonatomic) FLButtonContainerViewButtonSetupBlock onSetupButton;

- (void) addButton:(FLButton*) button;

@end

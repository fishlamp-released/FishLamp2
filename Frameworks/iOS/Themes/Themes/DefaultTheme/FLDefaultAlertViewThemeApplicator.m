//
//  FLAlertViewStyle.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/21/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLDefaultAlertViewThemeApplicator.h"

/*
FLDialogViewStyleBlock FLAlertStyleDefault = ^(FLDialogView* alert) {
    alert.padding = 20.0f;
    alert.cornerRadius = 10.0f;

    alert.
};

FLDialogViewStyleBlock FLAlertStyleNotificationBar = ^(FLDialogView* alert) {
    alert.padding = 10.0f;
    alert.cornerRadius = 0.0f;

//    alert.triangleSize = 20.0f;
//    [alert setCornerTriangleWithColorRange:[FLColorRange paleBlueGradientColorRange] inCorner:FLTriangleCornerUpperRight];
    
    alert.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
    alert.backgroundGradient.alpha = 0.7f;
    
//    [alert.backgroundGradient setColorRange:[FLColorRange darkGrayGradientColorRange] forControlState:UIControlStateNormal];
//    alert.backgroundGradient.alpha = 0.6f;
//
//    alert.titleLabel.textColor = [UIColor whiteColor];
//    alert.titleLabel.shadowColor = [UIColor gray10Color];
};
*/

#define kButtonHeight 40

#import "FLButtonContainerView.h"
#import "FLButton.h"


@implementation FLDefaultAlertViewThemeApplicator

+ (FLDefaultAlertViewThemeApplicator*) alertViewThemeApplicator {

    return nil;
}

- (void) setDialogButtonContainerStyle:(FLButtonContainerView*) containerView {
}

- (void) setupButtonInContainerView:(FLButtonContainerView*) view
                             button:(FLButton*) button {
    
    button.buttonStyle = ^(FLButton* theButton) {
        [theButton setShapeToRoundRect:6.0]; // 8.0f
        theButton.frame = CGRectMake(0,0,110, kButtonHeight);
        theButton.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
    };

    switch(button.buttonRole) {
        case FLButtonRoleNormal:
            button.buttonColors = FLButtonColorDarkGray;
        break;
        
        case FLButtonRoleConfirm:
            button.buttonColors = FLButtonColorDarkGray;
        break;
        
        case FLButtonRoleDelete:
            button.buttonColors = FLButtonColorRed;
        break;
        
        case FLButtonRoleCancel:
            button.buttonColors = FLButtonColorDarkGray;
        break;

        case FLButtonRoleDone:
            button.buttonColors = FLButtonColorBrightBlue;
        break;
    }
}
    
- (void) applyThemeToObject:(id) view {

//    view.buttonContainerView.arrangement = [FLCenterJustifiedColumnArrangement arrangement];
//    view.buttonContainerView.arrangement.innerInsets = UIEdgeInsetsMake(0,5,0,5);
//    view.cornerRadius = 10.f;
//    view.padding = 20.0f;
//    view.titleLabel.textColor = [UIColor gray10Color];
//    view.titleLabel.shadowColor = [UIColor whiteColor];
//    view.titleLabel.shadowOffset = CGSizeMake(0,1);
//    view.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]]; 
//    [view.backgroundGradient setColorRange:[FLColorRange lightLightGrayGradientColorRange] forControlState:UIControlStateNormal];
//    [view setNeedsLayout];
}

@end


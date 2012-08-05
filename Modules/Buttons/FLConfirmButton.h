//
//  FLYesButton.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/19/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLConfirmButton : FLButton

+ (FLButton*) okButton;
+ (FLButton*) okButton:(FLButtonPress)onPress;

+ (FLButton*) yesButton;
+ (FLButton*) yesButton:(FLButtonPress)onPress;

+ (FLButton*) saveButton;
+ (FLButton*) saveButton:(FLButtonPress)onPress;
@end

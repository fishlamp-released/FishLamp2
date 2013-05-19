//
//  FLYesButton.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/19/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <UIKit/UIKit.h>

#import "FLButton.h"

@interface FLConfirmButton : FLButton

+ (FLButton*) okButton;
+ (FLButton*) okButton:(FLButtonPress)onPress;

+ (FLButton*) yesButton;
+ (FLButton*) yesButton:(FLButtonPress)onPress;

+ (FLButton*) saveButton;
+ (FLButton*) saveButton:(FLButtonPress)onPress;
@end

//
//  FLDenyButton.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/19/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLDenyButton : FLButton

+ (FLButton*) cancelButton;
+ (FLButton*) cancelButton:(FLButtonPress)onPress;

+ (FLButton*) noButton;
+ (FLButton*) noButton:(FLButtonPress)onPress;

@end

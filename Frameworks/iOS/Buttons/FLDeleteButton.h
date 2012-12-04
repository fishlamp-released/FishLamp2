//
//  FLDeleteButton.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 7/19/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FLButton.h"

@interface FLDeleteButton : FLButton

+ (FLButton*) deleteButton;
+ (FLButton*) deleteButton:(FLButtonPress)onPress;

+ (FLButton*) removeButton;
+ (FLButton*) removeButton:(FLButtonPress)onPress;


@end

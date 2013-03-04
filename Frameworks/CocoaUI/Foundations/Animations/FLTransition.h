//
//  FLTransition.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/1/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAnimation.h"

@interface FLTransition : FLAnimation {
@private 
    UIView* _viewToShow;
    UIView* _viewToHide;
}

@property (readwrite, strong, nonatomic) UIView* viewToShow;
@property (readwrite, strong, nonatomic) UIView* viewToHide; 

- (id) initWithViewToShow:(UIView*) viewToShow 
               viewToHide:(UIView*) viewToHide;

+ (id) transitionWithViewToShow:(UIView*) viewToShow 
                     viewToHide:(UIView*) viewToHide;

@end

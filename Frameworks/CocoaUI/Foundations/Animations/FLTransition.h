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
}

- (id) initWithViewToShow:(UIView*) viewToShow 
               viewToHide:(UIView*) viewToHide;
               
+ (id) transitionWithViewToShow:(UIView*) viewToShow 
                     viewToHide:(UIView*) viewToHide;

- (void) prepareTransitionWithViewToShow:(UIView*) viewToShow 
                              viewToHide:(UIView*) viewToHide;
                              
- (void) finishTransitionWithViewToShow:(UIView*) viewToShow 
                             viewToHide:(UIView*) viewToHide;          
@end

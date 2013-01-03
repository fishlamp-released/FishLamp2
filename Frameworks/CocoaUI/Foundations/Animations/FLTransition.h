//
//  FLTransition.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/1/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLBatchAnimation.h"

@interface FLTransition : FLBatchAnimation {
}


- (id) initWithViewToShow:(UIView*) viewToShow 
               viewToHide:(UIView*) viewToHide;
               
+ (id) transitionWithViewToShow:(UIView*) viewToShow 
                     viewToHide:(UIView*) viewToHide;

- (void) setViewToShow:(UIView*) viewToShow 
            viewToHide:(UIView*) viewToHide;


// override this
- (void) addAnimationsForViewToShow:(UIView*) viewToShow 
                         viewToHide:(UIView*) viewToHide;


@end

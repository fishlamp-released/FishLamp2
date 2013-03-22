//
//  FLStatusBarViewController.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/2/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLViewController.h"

#if REFACTOR
@interface FLStatusBarViewController : FLViewController {
@private
    NSMutableArray* _stack;
}
- (void) setStatusView:(UIView*) view 
              animated:(BOOL) animated
              completion:(void (^)()) completion;

- (void) pushStatusView:(UIView*) view 
               animated:(BOOL) animated
               completion:(void (^)()) completion;
               
- (void) popStatusViewAnimated:(BOOL) animated 
                    completion:(void (^)()) completion;

- (void) removeAllStatusViewsAnimated:(BOOL) animated 
                           completion:(void (^)()) completion;
@end
#endif

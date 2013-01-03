//
//  FLViewController.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/2/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCocoaUIRequired.h"

#import "FLCocoaUIRequired.h"

#if OSX
#import "UIViewController+OSX.h"
#endif 

@interface FLViewController : NSViewController<UIViewControllerCompatibility> {
@private

#if OSX
    NSMutableArray* _childViewControllers;
    __unsafe_unretained UIViewController* _parentViewController;
    BOOL _viewLoaded;
#endif    
}

@end


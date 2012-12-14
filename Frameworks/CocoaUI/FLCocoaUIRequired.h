//
//  FLCocoaUIRequired.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/11/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCore.h"
#import "FLCocoa.h"
#import "NSObject+FLTheme.h"
#import "FLView.h"
#import "UIView+FLViewGeometry.h"
#import "UIViewController+FLAdditions.h"
#import "FLViewController.h"

#define FLWidgetView UIView

NS_INLINE
BOOL FLViewSetFrame(UIView* view, CGRect frame) {
    if(!CGRectEqualToRect(view.frame, frame)) {
        view.frame = frame;
        return YES;
    }
    return NO;
}
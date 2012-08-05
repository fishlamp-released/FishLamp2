//
//  FLAbstractAlertViewController.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 5/31/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLDialogViewController.h"
#import "FLDialogShapeView.h"


@implementation FLDialogViewController

+ (CGSize) defaultAutoPostionedViewSize {
    return DeviceIsPad() ? CGSizeMake(320,200) : CGSizeMake(260,200);
}

+ (id<FLPresentationBehavior>) defaultPresentationBehavior {
    return [FLModalPresentationBehavior instance];
}

+ (FLPopinViewControllerAnimation*) defaultTransitionAnimation {
    return [FLPopinViewControllerAnimation viewControllerTransitionAnimation];
}

- (id) init {
    FLAssert([NSThread currentThread] == [NSThread mainThread], @"Not on main thread");

    self = [super init];
    if(self) {
        self.contentMode = FLContentModeCentered;
        self.wantsApplyTheme = YES;
    }
    
    return self;
}

- (UIView*) createAutoPositionedViewWithFrame:(CGRect) frame {
    return FLReturnAutoreleased([[FLDialogShapeView alloc] initWithFrame:frame]);
}

@end
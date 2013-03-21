//
//  UIView_Internal.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#if OSX
#import "FLCompatibleView+OSX.h"
#import "FLCompatibleViewController+OSX.h"

@interface UIView ()
@property (readwrite, assign, nonatomic) UIViewController* viewController;
@end

#endif
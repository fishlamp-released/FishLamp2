//
//  FLProgressViewController.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 3/23/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#if IOS
#import "FLAutoPositionedViewController.h"
#else
#define FLAutoPositionedViewController NSViewController

#endif

#import "FLProgressViewControllerProtocol.h"
#import "FLPresentationBehavior.h"

// TODO: maybe this should be a NSProxy?
@interface FLProgressViewOwner : NSObject<FLProgressViewController> {
@private
    SDKView* _progressView;
    FLProgressViewControllerBlock _onShowProgress;
    FLProgressViewControllerBlock _onHideProgress;
}
@property (readwrite, retain, nonatomic) id progressView;

@property (readwrite, copy, nonatomic) FLProgressViewControllerBlock onHideProgress;
@property (readwrite, copy, nonatomic) FLProgressViewControllerBlock onShowProgress;

+ (FLProgressViewOwner*) progressViewOwner;
+ (FLProgressViewOwner*) progressViewOwner:(SDKView*) view;

/// SEE FLProgressViewController. This View Controller supports all the methods defined there.

@end

@interface FLProgressViewController : FLAutoPositionedViewController<FLProgressViewController> {
@private
    Class _viewClass;
    CGSize _minSize;
    FLProgressViewControllerBlock _onShowProgress;
    FLProgressViewControllerBlock _onHideProgress;
    FLProgressViewOwner* _progressProxy;
}

@property (readwrite, assign, nonatomic) CGSize minimumViewSize;

- (id) initWithProgressViewClass:(Class) viewClass;

+ (id) progressViewController:(Class) viewClass;
+ (id) progressViewController:(Class) viewClass presentationBehavior:(id<FLPresentationBehavior>) presentationBehavior;

// TODO(MF): Not implemented yet.
- (void) setStartDelay:(CGFloat) startDelay;

@end

#if IOS
@interface FLProgressViewController (Instantiation)
+ (FLProgressViewController*) simpleProgress;
+ (FLProgressViewController*) simpleModalProgress;
@end
#endif
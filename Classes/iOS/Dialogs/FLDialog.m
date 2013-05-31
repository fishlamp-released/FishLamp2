//
//  FLAbstractAlertViewController.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 5/31/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLDialog.h"
#import "FLDialogShapeView.h"

@interface FLDialog ()
@property (readwrite, strong, nonatomic) UIViewController* contentViewController;
@end

@implementation FLDialog

@synthesize contentViewController = _contentViewController;

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
    FLAssertWithComment([NSThread currentThread] == [NSThread mainThread], @"Not on main thread");

    self = [super init];
    if(self) {
        self.contentMode = FLRectLayoutCentered;
//        self.wantsApplyTheme = YES;
    }
    
    return self;
}

- (id) initWithViewController:(UIViewController*) viewController {
    self = [self init];
    if(self) {
        self.contentViewController = viewController;
    }
    return self;
}

+ (id) dialog:(UIViewController*) viewController {
    return FLAutorelease([[[self class] alloc] initWithViewController:viewController]);
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.contentViewController.view.autoresizingMask = UIViewAutoresizingFlexibleEverything;
    [self addChildViewController:self.contentViewController];
    [self.view addSubview:self.contentViewController.view];
    self.contentViewController.view.frame = self.view.bounds;
    
    [self.contentViewController viewDidLoadInDialog:self];
}

- (void) viewWillAppear:(BOOL) animated {
    [super viewWillAppear:animated];
    [self.contentViewController viewWillAppearInDialog:self];
}

- (void) viewDidAppear:(BOOL) animated {
    [super viewWillAppear:animated];
    [self.contentViewController viewDidAppearInDialog:self];
}

#if FL_MRC
- (void) dealloc {
    FLRelease(_contentViewController);
    FLSuperDealloc();
}
#endif

@end

@implementation UIViewController (FLDialog)
- (void) viewWillAppearInDialog:(FLDialog*) dialog {
}
- (void) viewDidAppearInDialog:(FLDialog*) dialog {
}
- (void) viewDidLoadInDialog:(FLDialog*) dialog {
}
@end
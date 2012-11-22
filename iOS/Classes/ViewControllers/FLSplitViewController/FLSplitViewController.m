//
//  FLSplitViewController.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/4/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLSplitViewController.h"

@interface FLSplitViewController ()
@property (readwrite, strong, nonatomic) UIViewController* topViewController;
@property (readwrite, strong, nonatomic) UIViewController* bottomViewController;
@end

@implementation FLSplitViewController

@synthesize topViewController = _topViewController; 
@synthesize bottomViewController = _bottomViewController; 

- (id) initWithTopViewController:(UIViewController*) topViewController 
            bottomViewController:(UIViewController*) bottomViewController {
            
    self = [super init];
    if(self) {
        self.topViewController = topViewController;
        self.bottomViewController = bottomViewController;
        _bottomPercentage = 0.2f;
    }
            
    return self;        
}

+ (FLSplitViewController*) splitViewController:(UIViewController*) topViewController
                          bottomViewController:(UIViewController*) bottomViewController {
   
     return autorelease_([[[self class] alloc] initWithTopViewController:topViewController bottomViewController:bottomViewController]);   
}

- (void) dealloc {
    release_(_topViewController);
    release_(_bottomViewController);
    release_(_splitterView);
    super_dealloc_();
}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void) _updateLayoutInBounds:(FLRect) bounds {
    _splitterView.frame = FLRectSetWidth(_splitterView.frame, bounds.size.width);
    self.topViewController.view.frame = CGRectMake(0,0, bounds.size.width, FLRectGetTop(_splitterView.frame));
    
// TODO: abstract this bottom bar stuff

    CGFloat toolbarAdjust = 0;
    
    if(self.viewContentsDescriptor.bottomItem == FLViewContentItemToolbar) {
        toolbarAdjust = 44.0f;
    }

    self.bottomViewController.view.frame = CGRectMake(0,FLRectGetBottom(_splitterView.frame), bounds.size.width, bounds.size.height - FLRectGetBottom(_splitterView.frame) - toolbarAdjust);
}

- (void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self _updateLayoutInBounds:self.view.bounds];
}

- (void) _setSplitterViewLocationByPercentage {
    _splitterView.frameOptimizedForLocation = FLRectSetTop(_splitterView.frame, self.view.bounds.size.height - _splitterView.frame.size.height - (self.view.bounds.size.height * _bottomPercentage));
    [self _updateLayoutInBounds:self.view.bounds];
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self _setSplitterViewLocationByPercentage];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    FLRect bounds = self.view.bounds;
    
    _splitterView = [[FLSplitterView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, 20.0f)];
    _splitterView.delegate = self;
    [self.view addSubview:_splitterView];
    
    [self presentChildViewController:self.topViewController];
    [self presentChildViewController:self.bottomViewController];
    [self _setSplitterViewLocationByPercentage];
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    FLReleaseWithNil_(_splitterView);
    
    // Release any retained subviews of the main view.
}

- (void) splitterViewWasMoved:(FLSplitterView*) splitterView {
    [self _updateLayoutInBounds:self.view.bounds];
    _bottomPercentage = _bottomViewController.view.frame.size.height / self.view.bounds.size.height;
}



@end

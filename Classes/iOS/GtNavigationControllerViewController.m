//
//	GtNavigationControllerViewController.m
//	FishLamp
//
//	Created by Mike Fullerton on 11/23/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtNavigationControllerViewController.h"
#import "GtNavigationController.h"
#import "GtHoverViewController.h"

@implementation GtNavigationControllerViewController

@synthesize rootNavigationController = m_navigationController;

- (id) initWithRootViewController:(UIViewController*) viewController
{
	if((self = [super init]))
	{
		m_rootViewController = GtRetain(viewController);
	    m_navigationController = [[GtNavigationController alloc] initWithRootViewController:m_rootViewController];
        m_navigationController.wantsFullScreenLayout = YES;
        
        [self addChildViewController:m_navigationController];
        
//        m_navigationController.superViewController = self;
    }
	
	return self;
}

+ (GtNavigationControllerViewController*) navigationControllerViewController:(UIViewController*) rootNavigationController
{
	return GtReturnAutoreleased([[GtNavigationControllerViewController alloc] initWithRootViewController:rootNavigationController]);
}

- (void) dealloc
{
	GtRelease(m_rootViewController);
	GtRelease(m_navigationController);
	GtSuperDealloc();
}

- (void) loadView
{
	self.view = GtReturnAutoreleased([[UIView alloc] initWithFrame:CGRectMake(0,0,320,640)]);
}

- (void) viewDidLoad
{
	[super viewDidLoad];
	
	self.view.backgroundColor = [UIColor clearColor];

//    CGSize size = m_rootViewController.view.frame.size;
        
    m_navigationController.navigationBar.barStyle = UIBarStyleBlack;
    m_navigationController.navigationBar.translucent = YES;
    m_navigationController.view.autoresizesSubviews = YES;
    m_navigationController.view.autoresizingMask = UIViewAutoresizingFlexibleEverything;
    
    [self.view addSubview:m_navigationController.view]; 
        
        // reset sizes back to what we want, thanks for nothing navigation Controller...
//    self.view.frame = GtRectSetSizeWithSize(self.view.frame, size);		
//    m_navigationController.view.frame = GtRectSetSizeWithSize(m_navigationController.view.frame, size);
//    m_rootViewController.view.frame = GtRectSetSizeWithSize(m_rootViewController.view.frame, size);
}

//-(void)viewWillAppear:(BOOL)animated 
//{ 
//	[super viewWillAppear:animated];
//	[m_navigationController viewWillAppear:animated];
//}
//
//-(void)viewWillDisappear:(BOOL)animated 
//{ 
//	[super viewWillDisappear:animated];
//	[m_navigationController viewWillDisappear:animated];
//}
//
//-(void)viewDidAppear:(BOOL)animated 
//{ 
//	[super viewDidAppear:animated];
//	[m_navigationController viewDidAppear:animated];
//}

- (void) willShowInHoverViewController:(GtHoverViewController*) controller
{
    [m_navigationController willShowInHoverViewController:controller];
}

- (void) didShowInHoverViewController:(GtHoverViewController*) controller
{
    [m_navigationController didShowInHoverViewController:controller];
}

//-(void)viewDidDisappear:(BOOL)animated 
//{ 
//	[super viewDidDisappear:animated];
//	[m_navigationController viewDidDisappear:animated];
//}

@end

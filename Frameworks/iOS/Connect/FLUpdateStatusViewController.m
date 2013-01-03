//
//  FLUpdateStatusViewController.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/14/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLUpdateStatusViewController.h"
#import "FLTextView.h"
#import "FLFloatingMenuViewController.h"
#import "UIImage+Colorize.h"
#import "FLNavigationControllerViewController.h"
#import "FLFloatingViewController.h"

@implementation FLUpdateStatusViewController

@synthesize textEditingButtonbar = _textEditingBar;
@synthesize userHeaderView = _headerView;

+ (FLUpdateStatusViewController*) updateStatusViewController
{
	return FLAutorelease([[FLUpdateStatusViewController alloc] init]);
}

- (void) _settingsPressed:(id) sender 
{
	FLFloatingMenuViewController* controller = [FLFloatingMenuViewController menuViewController:nil];

    [controller.menuView addMenuItem:[FLMenuItemView menuItemView:NSLocalizedString(@"Shorten Links", nil) target:self action:@selector(shortenLinks)]];

    [controller.menuView addMenuItem:[FLMenuItemView menuItemView:NSLocalizedString(@"Clear All Text", nil) target:self action:@selector(clearText)]];

 //   [[UIApplication visibleViewController] presentModalFloatingViewController:[FLNavigationControllerViewController navigationControllerViewController:self] animated:YES];

//    FLFloatingViewController* floatingView = [FLFloatingViewController floatingViewController:controller];
//    [floatingView presentInViewController:[FLFloatingViewController defaultParentViewController]
//               permittedArrowDirection:FLFloatingViewControllerArrowDirectionUp
//                  fromPositionProvider:[self.buttonbar viewForKey:@"settings"]
//                                 style:FLFloatingViewStyleNormal
//                              animated:YES];

//
//	[FLFloatingViewController presentViewController:controller
//			permittedArrowDirections:FLFloatingViewControllerArrowDirectionUp 
//			fromObject:[self.buttonbar viewForKey:@"settings"]
//			animated:YES];

}

- (void) dealloc
{
	FLRelease(_textEditingBar);
	FLRelease(_editingBar);
	FLSuperDealloc();
}

- (void) viewDidUnload
{	
	FLReleaseWithNil(_editingBar);
	FLReleaseWithNil(_textEditingBar);
    [super viewDidUnload];
}

- (void) shortenLinks
{
}

- (void) clearText
{
	self.textEditView.text = @"";
	[self.textEditView handleTextDidChange];
}

- (void) beginLoadingForUserHeader
{
}

- (void) viewDidLoad
{
	[self.buttonbar addViewToRightSide:
	[FLDeprecatedButtonbarView createImageButtonByName:@"settings.png" imageColor:FLImageColorBlack target:self action:@selector(_settingsPressed:)] 
		forKey:@"settings" 
		animated:NO];
		
	[super viewDidLoad];
	
	_headerView = [[FLUserHeaderView alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width, 50.f)];

	[self beginLoadingForUserHeader];
}



@end

//
//  GtUpdateStatusViewController.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/14/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtUpdateStatusViewController.h"
#import "GtTextView.h"
#import "GtMenuInHoverViewController.h"
#import "UIImage+GtColorize.h"
#import "GtNavigationControllerViewController.h"
#import "GtHoverViewController.h"

@implementation GtUpdateStatusViewController

@synthesize textEditingButtonbar = m_textEditingBar;
@synthesize userHeaderView = m_headerView;

+ (GtUpdateStatusViewController*) updateStatusViewController
{
	return GtReturnAutoreleased([[GtUpdateStatusViewController alloc] init]);
}

- (void) _settingsPressed:(id) sender 
{
	GtMenuInHoverViewController* controller = [GtMenuInHoverViewController menuViewController:nil];

    [controller.menuView addMenuItem:[GtMenuItemView menuItemView:NSLocalizedString(@"Shorten Links", nil) target:self action:@selector(shortenLinks)]];

    [controller.menuView addMenuItem:[GtMenuItemView menuItemView:NSLocalizedString(@"Clear All Text", nil) target:self action:@selector(clearText)]];

    GtHoverViewController* hoverView = [GtHoverViewController hoverViewController:controller];
    [hoverView presentInViewController:[GtHoverViewController defaultParentViewController]
               permittedArrowDirection:GtHoverViewControllerArrowDirectionUp
                  fromPositionProvider:[self.buttonbar viewForKey:@"settings"]
                                 style:GtHoverViewStyleNormal
                              animated:YES];

//
//	[GtHoverViewController presentViewController:controller
//			permittedArrowDirections:GtHoverViewControllerArrowDirectionUp 
//			fromObject:[self.buttonbar viewForKey:@"settings"]
//			animated:YES];

}

- (void) dealloc
{
	GtRelease(m_textEditingBar);
	GtRelease(m_editingBar);
	GtSuperDealloc();
}

- (void) viewDidUnload
{	
	GtReleaseWithNil(m_editingBar);
	GtReleaseWithNil(m_textEditingBar);
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
	[GtButtonbarView createImageButtonByName:@"settings.png" target:self action:@selector(_settingsPressed:)] 
		forKey:@"settings" 
		animated:NO];
		
	[super viewDidLoad];
	
	m_headerView = [[GtUserHeaderView alloc] initWithFrame:CGRectMake(0,0,self.view.bounds.size.width, 50.f)];

	[self beginLoadingForUserHeader];
}



@end

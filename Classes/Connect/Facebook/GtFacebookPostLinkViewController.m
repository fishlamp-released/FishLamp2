//
//  GtFacebookPostLinkViewController.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/6/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFacebookPostLinkViewController.h"
#import "GtAction.h"
#import "GtOldProgressView.h"
#import "GtFacebookMgr.h"
#import "GtFacebookOperation.h"
#import "GtHoverViewController.h"
#import "GtNavigationControllerViewController.h"
#import "GtFacebookAuthenticator.h"

@implementation GtFacebookPostLinkViewController

- (id) initWithLink:(GtFacebookLink*) fbLink
{
	if((self = [super init]))
	{
		m_link = GtRetain(fbLink);
		self.title = NSLocalizedString(@"Post Link on Facebook", nil);
		self.saveButtonTitle = NSLocalizedString(@"Share", nil);
        self.maxSize = 500;
	}
	return self;
}

+ (GtFacebookPostLinkViewController*) facebookPostLinkViewController:(GtFacebookLink*) fbLink
{
	return GtReturnAutoreleased([[GtFacebookPostLinkViewController alloc] initWithLink:fbLink]);
}

+ (GtFacebookPostLinkViewController*) facebookPostLinkViewController
{
	return GtReturnAutoreleased([[GtFacebookPostLinkViewController alloc] init]);
}	

- (void) dealloc
{
    GtRelease(m_linkLabel);
	GtRelease(m_headerView);
	GtSuperDealloc();
}

- (void) viewDidUnload
{   
    GtReleaseWithNil(m_linkLabel);
	GtReleaseWithNil(m_headerView);
	[super viewDidUnload];
}

- (void) presentTextIsTooLongMessage
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Your status update is too long.", nil)
        message:[NSString stringWithFormat:(NSLocalizedString(@"The maximum status length is 500 characters but yours is %d characters long.", nil)), self.textLength]
        delegate:nil
        cancelButtonTitle:NSLocalizedString(@"OK", nil)
        otherButtonTitles:nil];
     
    GtAutorelease(alert);       
        
    [alert show];
}

- (void) configureContentView
{
	m_headerView = [[GtFacebookUserHeader alloc] initWithFrame:CGRectMake(0,0,0, 50)];
	[self.contentView addSubview:m_headerView];
	
	m_linkLabel = [[GtLabel alloc] initWithFrame:CGRectMake(0,0,0, 20)];
	m_linkLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
	m_linkLabel.textColor = [UIColor lightGrayColor];
	m_linkLabel.backgroundColor = [UIColor clearColor];

	if(GtStringIsNotEmpty(m_link.link))
	{
		m_linkLabel.text = m_link.link;
	}
	else if(GtStringIsNotEmpty(m_link.picture))
	{
		m_linkLabel.text = m_link.picture;
	}

	m_linkLabel.viewLayoutBehavior = [GtViewLayoutBehavior viewLayoutBehavior];
    m_linkLabel.viewLayoutBehavior.margins	= UIEdgeInsetsMake(0, 0, -8, 0);
    
	[self.contentView addSubview:m_linkLabel];
	
	[self.contentView addSubview:self.textEditView];
	
	self.textEditView.frame = GtRectSetHeight(self.textEditView.frame, DeviceIsPad() ? 160: 80);

	self.contentView.viewLayout = [GtRowViewLayout viewLayout];
	self.contentView.viewLayout.viewMargins = UIEdgeInsetsMake(0,0,10.0,0);
	self.contentView.viewLayout.padding = UIEdgeInsets10;

	self.textEditView.placeholderText = NSLocalizedString(@"Say something about your link…", nil);

}

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[m_headerView beginLoadingInActionContext:self.actionContext];
}

- (BOOL) canUpdateSaveButtonEnabledState
{
	return NO;
}

- (void) beginPostingLink
{
	m_link.message = self.text;

	GtNetworkAction* action = [GtNetworkAction action];
	[self.actionContext beginAction:action configureAction:^(id inAction) {
		action.progressView = [GtProgressViewController progressViewController:[GtOldProgressView defaultModalProgressView]];
		action.actionDescription.itemName = NSLocalizedString(@"Link", nil);
		action.actionDescription.actionType = GtActionDescriptionTypeUpdate;
	//	action.networkRequired = YES;
		[action queueOperation:[GtFacebookOperation facebookOperation] 
			configureOperation:^(id operation) {
				[operation setObject: @"feed"];
				[operation setInput: m_link];
				[operation setRequestWillPost];
			}]; 
				
		action.didCompleteCallback = ^{

			if(action.didFinishWithoutError)
			{
				[m_postLinkDelegate facebookPostLinkViewControllerDidPostLink:self];
			}
			else
			{
				[m_postLinkDelegate facebookPostLinkViewController:self didFailWithError:action.error];
			}
			
		};
	}];	
}

- (void) beginSaving
{
	[self beginPostingLink];
}

- (void) beginCancel    
{
    [m_postLinkDelegate facebookPostLinkViewControllerWasCancelled:self];
}

- (void) facebookAuthenticator:(GtFacebookAuthenticator*) authenticator 
    presentAuthenticationViewController:(GtFacebookLoginViewController*) viewController
{
    [authenticator.viewController presentModalViewController:[GtNavigationControllerViewController navigationControllerViewController:viewController] animated:YES];
}

- (void) facebookAuthenticator:(GtFacebookAuthenticator*) authenticator 
    dismissAuthenticationViewController:(GtFacebookLoginViewController*) viewController
{
    [authenticator.viewController dismissModalViewControllerAnimated:YES];
}

- (void) facebookAuthenticator:(GtFacebookAuthenticator*) authenticator authenticationDidComplete:(GtFacebookNetworkSession*) session
{
    if(DeviceIsPad())
    {
        GtHoverViewController* hoverView = [GtHoverViewController hoverViewController:[GtNavigationControllerViewController navigationControllerViewController:self]];
        [hoverView presentInViewController:[GtHoverViewController defaultParentViewController]
               permittedArrowDirection:GtHoverViewControllerArrowDirectionNone
                  fromPositionProvider:nil
                                 style:GtHoverViewStyleNormal
                              animated:YES];

    
    
//        [GtHoverViewController presentModalViewController:[GtNavigationControllerViewController navigationControllerViewController:self] animated:YES];
    }
    else
    {
        self.modalParentViewController = authenticator.viewController;
        [authenticator.viewController presentModalViewController:[GtNavigationControllerViewController navigationControllerViewController:self] animated:YES];
    }
}
- (void) facebookAuthenticator:(GtFacebookAuthenticator*) authenticator authenticationDidFail:(NSError*) error
{
	[m_postLinkDelegate facebookPostLinkViewController:self didFailWithError:error];
}

- (void) facebookAuthenticatorWasCancelled:(GtFacebookAuthenticator*) authenticator
{
    [m_postLinkDelegate facebookPostLinkViewControllerWasCancelled:self];
}

- (void) presentInViewController:(GtViewController*) viewController delegate:(id<GtFacebookPostLinkViewControllerDelegate>) delegate
{
	m_postLinkDelegate = delegate;
    
    GtFacebookAuthenticator* auth = [GtFacebookAuthenticator facebookAuthenticator];
	[auth beginAuthenticatingInViewController:viewController delegate:self];
}

@end

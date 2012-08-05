//
//  FLFacebookPostLinkViewController.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/6/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLFacebookPostLinkViewController.h"
#import "FLAction.h"
#import "FLLegacyProgressView.h"
#import "FLFacebookMgr.h"
#import "FLFacebookOperation.h"
#import "FLFloatingViewController.h"
#import "FLNavigationControllerViewController.h"
#import "FLFacebookAuthenticator.h"
#import "FLProgressViewController.h"
#import "FLSimpleProgressView.h"
#import "FLSingleRowColumnArrangement.h"
#import "FLAlertViewController.h"
#import "FLButtons.h"

@implementation FLFacebookPostLinkViewController

- (id) initWithLink:(FLFacebookLink*) fbLink
{
	if((self = [super init]))
	{
		m_link = FLReturnRetained(fbLink);
		self.title = NSLocalizedString(@"Post Link on Facebook", nil);
		self.saveButtonTitle = NSLocalizedString(@"Share", nil);
        self.maxSize = 500;
	}
	return self;
}

+ (FLFacebookPostLinkViewController*) facebookPostLinkViewController:(FLFacebookLink*) fbLink
{
	return FLReturnAutoreleased([[FLFacebookPostLinkViewController alloc] initWithLink:fbLink]);
}

+ (FLFacebookPostLinkViewController*) facebookPostLinkViewController
{
	return FLReturnAutoreleased([[FLFacebookPostLinkViewController alloc] init]);
}	

- (void) dealloc
{
    FLRelease(m_linkLabel);
	FLRelease(m_headerView);
	FLSuperDealloc();
}

- (void) viewDidUnload
{   
    FLReleaseWithNil(m_linkLabel);
	FLReleaseWithNil(m_headerView);
	[super viewDidUnload];
}

- (void) presentTextIsTooLongMessage
{
    FLAlertViewController* alert = [FLAlertViewController alertViewController:NSLocalizedString(@"Your status update is too long.", nil)
        message:[NSString stringWithFormat:(NSLocalizedString(@"The maximum status length is 500 characters but yours is %d characters long.", nil)), self.textLength]];
        
    [alert addButton:[FLConfirmButton okButton]];
    [alert presentViewControllerAnimated:YES];
}

- (void) configureContentView
{
	m_headerView = [[FLFacebookUserHeader alloc] initWithFrame:CGRectMake(0,0,0, 50)];
	[self.contentView addSubview:m_headerView];
	
	m_linkLabel = [[FLLabel alloc] initWithFrame:CGRectMake(0,0,0, 20)];
	m_linkLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
	m_linkLabel.textColor = [UIColor lightGrayColor];
	m_linkLabel.backgroundColor = [UIColor clearColor];

	if(FLStringIsNotEmpty(m_link.link))
	{
		m_linkLabel.text = m_link.link;
	}
	else if(FLStringIsNotEmpty(m_link.picture))
	{
		m_linkLabel.text = m_link.picture;
	}

    m_linkLabel.arrangeableInsets	= UIEdgeInsetsMake(0, 0, -8, 0);
    
	[self.contentView addSubview:m_linkLabel];
	
	[self.contentView addSubview:self.textEditView];
	
	self.textEditView.frame = FLRectSetHeight(self.textEditView.frame, DeviceIsPad() ? 160: 80);

	self.contentView.subviewArrangement = [FLSingleRowColumnArrangement arrangement];
	self.contentView.subviewArrangement.arrangeableInsets = UIEdgeInsetsMake(0,0,10.0,0);
	self.contentView.subviewArrangement.arrangementInsets = FLEdgeInsets10;

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

	FLNetworkAction* action = [FLNetworkAction action];
    action.progressController = [FLProgressViewController progressViewController:[FLSimpleProgressView class]];
    action.actionDescription.actionItemName = NSLocalizedString(@"Link", nil);
    action.actionDescription.actionType = FLActionDescriptionTypeUpdate;
//	action.networkRequired = YES;

    FLFacebookOperation* operation= [FLFacebookOperation facebookOperation];
    [operation setObject: @"feed"];
    [operation setInput: m_link];
    [operation setRequestWillPost];

    [action queueOperation:operation];
            
    action.onFinished = ^(id theAction) {
        if(action.didFinishWithoutError)
        {
            [m_postLinkDelegate facebookPostLinkViewControllerDidPostLink:self];
        }
        else
        {
            [m_postLinkDelegate facebookPostLinkViewController:self didFailWithError:action.error];
        }
    };
    
    
	[self.actionContext beginAction:action];
}

- (void) beginSaving
{
	[self beginPostingLink];
}

- (void) beginCancel    
{
    [m_postLinkDelegate facebookPostLinkViewControllerWasCancelled:self];
}

- (void) facebookAuthenticator:(FLFacebookAuthenticator*) authenticator 
    presentAuthenticationViewController:(FLFacebookLoginViewController*) viewController
{
    [authenticator.viewController presentModalViewController:[FLNavigationControllerViewController navigationControllerViewController:viewController] animated:YES];
}

- (void) facebookAuthenticator:(FLFacebookAuthenticator*) authenticator 
    dismissAuthenticationViewController:(FLFacebookLoginViewController*) viewController
{
    [authenticator.viewController dismissModalViewControllerAnimated:YES];
}

- (void) facebookAuthenticator:(FLFacebookAuthenticator*) authenticator authenticationDidComplete:(FLFacebookNetworkSession*) session
{
    if(DeviceIsPad())
    {
        [[UIApplication visibleViewController] presentFloatingViewController:[FLNavigationControllerViewController navigationControllerViewController:self] 
            withBehavior:[FLModalPresentationBehavior instance]
            withAnimation:nil];
    }
    else
    {
        self.modalParentViewController = authenticator.viewController;
        [authenticator.viewController presentModalViewController:[FLNavigationControllerViewController navigationControllerViewController:self] animated:YES];
    }
}
- (void) facebookAuthenticator:(FLFacebookAuthenticator*) authenticator authenticationDidFail:(NSError*) error
{
	[m_postLinkDelegate facebookPostLinkViewController:self didFailWithError:error];
}

- (void) facebookAuthenticatorWasCancelled:(FLFacebookAuthenticator*) authenticator
{
    [m_postLinkDelegate facebookPostLinkViewControllerWasCancelled:self];
}

- (void) presentInViewController:(FLViewController*) viewController delegate:(id<FLFacebookPostLinkViewControllerDelegate>) delegate
{
	m_postLinkDelegate = delegate;
    
    FLFacebookAuthenticator* auth = [FLFacebookAuthenticator facebookAuthenticator];
	[auth beginAuthenticatingInViewController:viewController delegate:self];
}

@end

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
#import "FLAlert.h"
#import "FLButtons.h"

@implementation FLFacebookPostLinkViewController

- (id) initWithLink:(FLFacebookLink*) fbLink
{
	if((self = [super init]))
	{
		_link = retain_(fbLink);
		self.title = NSLocalizedString(@"Post Link on Facebook", nil);
		self.saveButtonTitle = NSLocalizedString(@"Share", nil);
        self.maxSize = 500;
	}
	return self;
}

+ (FLFacebookPostLinkViewController*) facebookPostLinkViewController:(FLFacebookLink*) fbLink
{
	return autorelease_([[FLFacebookPostLinkViewController alloc] initWithLink:fbLink]);
}

+ (FLFacebookPostLinkViewController*) facebookPostLinkViewController
{
	return autorelease_([[FLFacebookPostLinkViewController alloc] init]);
}	

- (void) dealloc
{
    mrc_release_(_linkLabel);
	mrc_release_(_headerView);
	mrc_super_dealloc_();
}

- (void) viewDidUnload
{   
    FLReleaseWithNil_(_linkLabel);
	FLReleaseWithNil_(_headerView);
	[super viewDidUnload];
}

- (void) presentTextIsTooLongMessage
{
    FLAlert* alert = [FLAlert alertViewController:NSLocalizedString(@"Your status update is too long.", nil)
        message:[NSString stringWithFormat:(NSLocalizedString(@"The maximum status length is 500 characters but yours is %d characters long.", nil)), self.textLength]];
        
    [alert addButton:[FLConfirmButton okButton]];
    [alert presentViewControllerAnimated:YES];
}

- (void) configureContentView
{
	_headerView = [[FLFacebookUserHeader alloc] initWithFrame:CGRectMake(0,0,0, 50)];
	[self.contentView addSubview:_headerView];
	
	_linkLabel = [[FLLabel alloc] initWithFrame:CGRectMake(0,0,0, 20)];
	_linkLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
	_linkLabel.textColor = [UIColor lightGrayColor];
	_linkLabel.backgroundColor = [UIColor clearColor];

	if(FLStringIsNotEmpty(_link.link)) {
		_linkLabel.text = _link.link;
	}
	else if(FLStringIsNotEmpty(_link.picture)) {
		_linkLabel.text = _link.picture;
	}

    _linkLabel.innerInsets	= UIEdgeInsetsMake(0, 0, -8, 0);
    
	[self.contentView addSubview:_linkLabel];
	
	[self.contentView addSubview:self.textEditView];
	
	self.textEditView.frame = FLRectSetHeight(self.textEditView.frame, DeviceIsPad() ? 160: 80);

	self.contentView.arrangement = [FLSingleRowColumnArrangement arrangement];
	self.contentView.arrangement.innerInsets = UIEdgeInsetsMake(0,0,10.0,0);
	self.contentView.arrangement.outerInsets = FLEdgeInsets10;

	self.textEditView.placeholderText = NSLocalizedString(@"Say something about your link…", nil);

}

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[_headerView startLoadingInViewController:self];
}

- (BOOL) canUpdateSaveButtonEnabledState
{
	return NO;
}

- (void) beginPostingLink
{
	_link.message = self.text;

	FLNetworkAction* action = [FLNetworkAction action];
    action.progressController = [FLProgressViewController progressViewController:[FLSimpleProgressView class]];
    action.actionDescription.actionItemName = NSLocalizedString(@"Link", nil);
    action.actionDescription.actionType = FLActionDescriptionTypeUpdate;
//	action.networkRequired = YES;

    FLFacebookOperation* operation= [FLFacebookOperation facebookOperation];
    [operation setObject: @"feed"];
    [operation setInput: _link];
    [operation setRequestWillPost];

    [action addOperation:operation];
            
    [self startAction:action completion: ^(FLResult result) {
        if(action.didSucceed) {
            [_postLinkDelegate facebookPostLinkViewControllerDidPostLink:self];
        }
        else {
            [_postLinkDelegate facebookPostLinkViewController:self didFailWithError:action.error];
        }
    }];
}

- (void) beginSaving
{
	[self beginPostingLink];
}

- (void) beginCancel    
{
    [_postLinkDelegate facebookPostLinkViewControllerWasCancelled:self];
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
	[_postLinkDelegate facebookPostLinkViewController:self didFailWithError:error];
}

- (void) facebookAuthenticatorWasCancelled:(FLFacebookAuthenticator*) authenticator
{
    [_postLinkDelegate facebookPostLinkViewControllerWasCancelled:self];
}

- (void) presentInViewController:(FLViewController*) viewController delegate:(id<FLFacebookPostLinkViewControllerDelegate>) delegate
{
	_postLinkDelegate = delegate;
    
    FLFacebookAuthenticator* auth = [FLFacebookAuthenticator facebookAuthenticator];
	[auth beginAuthenticatingInViewController:viewController delegate:self];
}

@end

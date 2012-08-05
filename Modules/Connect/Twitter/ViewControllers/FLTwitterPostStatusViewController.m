//
//  FLTwitterPostStatusViewController.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/4/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLTwitterPostStatusViewController.h"
#import "FLTwitterAuthenticator.h"
#import "FLNavigationControllerViewController.h"
#import "FLTwitterPostStatusOperation.h"
#import "FLLegacyProgressView.h"
#import "FLFloatingViewController.h"
#import "FLNavigationControllerViewController.h"
#import "FLAlertViewController.h"
#import "FLProgressViewController.h"
#import "FLSimpleProgressView.h"
#import "FLSingleColumnRowArrangement.h"
#import "FLArrangement.h"
#import "FLButtons.h"

@implementation FLTwitterPostStatusViewController

@synthesize statusUpdate = m_statusUpdate;
@synthesize userGuid = m_userGuid;

- (id) initWithStatusUpdate:(FLTwitterStatusUpdate*) update userGuid:(NSString*) userGuid
{
	if((self = [super init]))
	{
		self.statusUpdate = update;
		self.userGuid = userGuid;
		self.title = NSLocalizedString(@"Compose Tweet", nil);
		
		self.saveButtonTitle = NSLocalizedString(@"Tweet", nil);
		
		self.maxSize = 140;
	}
	
	return self;
}

+ (FLTwitterPostStatusViewController*) twitterPostStatusViewController:(FLTwitterStatusUpdate*) update  userGuid:(NSString*) userGuid
{
	return FLReturnAutoreleased([[FLTwitterPostStatusViewController alloc] initWithStatusUpdate:update userGuid:userGuid]);
}

- (void) dealloc
{
    FLRelease(m_headerView);
	FLRelease(m_userGuid);
	FLRelease(m_statusUpdate);
	FLSuperDealloc();
}

- (void) twitterAuthenticator:(FLTwitterAuthenticator*) authenticator 
    presentAuthenticationViewController:(FLOAuthAuthorizationViewController*) viewController
{
    [authenticator.viewController presentModalViewController:[FLNavigationControllerViewController navigationControllerViewController:viewController] animated:YES];
}

- (void) twitterAuthenticator:(FLTwitterAuthenticator*) authenticator 
    dismissAuthenticationViewController:(FLOAuthAuthorizationViewController*) viewController
{
    [authenticator.viewController dismissModalViewControllerAnimated:YES];
}

- (void) setStatusUpdate:(FLTwitterStatusUpdate *)statusUpdate
{
    FLAssignObject(m_statusUpdate, statusUpdate);
    self.text = m_statusUpdate.status;
}

- (void) viewDidUnload
{
    [super viewDidUnload];
    FLReleaseWithNil(m_headerView);
}

- (void) presentTextIsTooLongMessage
{
    FLAlertViewController* alert = [FLAlertViewController alertViewController:NSLocalizedString(@"Your tweet is too long.", nil)
                                                                      message:[NSString stringWithFormat:(NSLocalizedString(@"The tweet length is 140 characters but yours is %d characters long.", nil)), self.textLength]];
    [alert addButton:[FLConfirmButton okButton]];
    [alert presentViewControllerAnimated:YES];
}

- (void) beginSaving
{
	m_statusUpdate.status = self.text;

	FLAction* action = [FLAction action];
    action.progressController = [FLProgressViewController progressViewController:[FLSimpleProgressView class]];
    action.actionDescription.actionItemName = NSLocalizedString(@"Status", nil);
    action.actionDescription.actionType = FLActionDescriptionTypeUpdate;
//	action.networkRequired = YES;

    FLTwitterPostStatusOperation* operation = [FLTwitterPostStatusOperation operation];
    [operation setTwitterSession:[[FLTwitterMgr instance] sessionForUserGuid:self.userGuid]];
    [operation setInput:m_statusUpdate];
    [action queueOperation:operation];
        
    action.onFinished = ^(id theAction) {
        if([theAction didFinishWithoutError])
        {
            [m_postDelegate twitterPostStatusViewController:self didPostStatus:m_statusUpdate];
        }
        else
        {
            [m_postDelegate twitterPostStatusViewController:self didFail:[theAction error]];
        }
    };
	[self.actionContext beginAction:action];
}

- (void) beginCancel    
{
    [m_postDelegate twitterPostStatusViewControllerWasCancelled:self];
}

- (void) configureContentView
{
    self.contentView.subviewArrangement = [FLSingleColumnRowArrangement arrangement];
	self.contentView.subviewArrangement.arrangeableInsets = UIEdgeInsetsMake(0,0,10.0,0);
	self.contentView.subviewArrangement.arrangementInsets = FLEdgeInsets10;

	m_headerView = [[FLTwitterUserHeaderView alloc] initWithFrame:CGRectMake(0,0,0, 50)];
	[self.contentView addSubview:m_headerView];
	
    self.textEditView.placeholderText = NSLocalizedString(@"What's happening?", nil);
	self.textEditView.frame = FLRectSetHeight(self.textEditView.frame, 80);
	[self.contentView addSubview:self.textEditView];
}

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[m_headerView beginLoadingInActionContext:self.actionContext userGuid:self.userGuid];
}

- (void) twitterAuthenticator:(FLTwitterAuthenticator*) authenticator didAuthenticateUser:(NSString*) userGuid
{
    UIViewController* newController = [FLNavigationControllerViewController navigationControllerViewController:self];
    if(DeviceIsPad())
    {
        [[UIApplication visibleViewController] presentFloatingViewController:newController 
            withBehavior:[FLModalPresentationBehavior instance]
            withAnimation:[FLPopinViewControllerAnimation viewControllerTransitionAnimation]];
    }
    else
    {
        self.modalParentViewController = authenticator.viewController;
        [authenticator.viewController presentModalViewController:newController animated:YES];
    }
}

- (void) twitterAuthenticator:(FLTwitterAuthenticator*) authenticator didFail:(NSError*) error
{
	[m_postDelegate twitterPostStatusViewController:self didFail:error];
}

- (void) twitterAuthenticatorWasCancelled:(FLTwitterAuthenticator*) authenticator
{
    [m_postDelegate twitterPostStatusViewControllerWasCancelled:self];
}

- (void) presentInViewController:(FLViewController*) viewController delegate:(id<FLTwitterPostStatusViewControllerDelegate>) delegate
{
	m_postDelegate = delegate;		
    
    FLTwitterAuthenticator* authenticator = [FLTwitterAuthenticator twitterAuthenticator];
    [authenticator beginAuthenticatingInViewController:viewController userGuid:self.userGuid delegate:self];
}

@end

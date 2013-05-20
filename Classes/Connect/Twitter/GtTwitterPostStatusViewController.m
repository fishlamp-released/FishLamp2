//
//  GtTwitterPostStatusViewController.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/4/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTwitterPostStatusViewController.h"
#import "GtTwitterAuthenticator.h"
#import "GtNavigationControllerViewController.h"
#import "GtTwitterPostStatusOperation.h"
#import "GtOldProgressView.h"
#import "GtHoverViewController.h"
#import "GtNavigationControllerViewController.h"
#import "GtAlertView.h"

@implementation GtTwitterPostStatusViewController

@synthesize statusUpdate = m_statusUpdate;
@synthesize userGuid = m_userGuid;

- (id) initWithStatusUpdate:(GtTwitterStatusUpdate*) update userGuid:(NSString*) userGuid
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

+ (GtTwitterPostStatusViewController*) twitterPostStatusViewController:(GtTwitterStatusUpdate*) update  userGuid:(NSString*) userGuid
{
	return GtReturnAutoreleased([[GtTwitterPostStatusViewController alloc] initWithStatusUpdate:update userGuid:userGuid]);
}

- (void) dealloc
{
    GtRelease(m_headerView);
	GtRelease(m_userGuid);
	GtRelease(m_statusUpdate);
	GtSuperDealloc();
}

- (void) twitterAuthenticator:(GtTwitterAuthenticator*) authenticator 
    presentAuthenticationViewController:(GtOAuthAuthorizationViewController*) viewController
{
    [authenticator.viewController presentModalViewController:[GtNavigationControllerViewController navigationControllerViewController:viewController] animated:YES];
}

- (void) twitterAuthenticator:(GtTwitterAuthenticator*) authenticator 
    dismissAuthenticationViewController:(GtOAuthAuthorizationViewController*) viewController
{
    [authenticator.viewController dismissModalViewControllerAnimated:YES];
}

- (void) setStatusUpdate:(GtTwitterStatusUpdate *)statusUpdate
{
    GtAssignObject(m_statusUpdate, statusUpdate);
    self.text = m_statusUpdate.status;
}

- (void) viewDidUnload
{
    [super viewDidUnload];
    GtReleaseWithNil(m_headerView);
}

- (void) presentTextIsTooLongMessage
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Your tweet is too long.", nil)
        message:[NSString stringWithFormat:(NSLocalizedString(@"The tweet length is 140 characters but yours is %d characters long.", nil)), self.textLength]
        delegate:nil
        cancelButtonTitle:NSLocalizedString(@"OK", nil)
        otherButtonTitles:nil];
    GtAutorelease(alert);
        
    [alert show];
}

- (void) beginSaving
{
	m_statusUpdate.status = self.text;

	GtAction* action = [GtAction action];
	[self.actionContext beginAction:action configureAction:^(id inAction) {
		action.progressView = [GtProgressViewController progressViewController:[GtOldProgressView defaultModalProgressView]];
		action.actionDescription.itemName = NSLocalizedString(@"Status", nil);
		action.actionDescription.actionType = GtActionDescriptionTypeUpdate;
	//	action.networkRequired = YES;
		[action queueOperation:[GtTwitterPostStatusOperation operation]
			configureOperation:^(id operation) {
				[operation setTwitterSession:[[GtTwitterMgr instance] sessionForUserGuid:self.userGuid]];
				[operation setInput:m_statusUpdate];
			} ];
			
		action.didCompleteCallback = ^{
        
            if(action.didFinishWithoutError)
            {
                [m_postDelegate twitterPostStatusViewController:self didPostStatus:m_statusUpdate];
            }
            else
            {
                [m_postDelegate twitterPostStatusViewController:self didFail:action.error];
            }
        };
	}];	
}

- (void) beginCancel    
{
    [m_postDelegate twitterPostStatusViewControllerWasCancelled:self];
}

- (void) configureContentView
{
    self.contentView.viewLayout = [GtRowViewLayout viewLayout];
	self.contentView.viewLayout.viewMargins = UIEdgeInsetsMake(0,0,10.0,0);
	self.contentView.viewLayout.padding = UIEdgeInsets10;

	m_headerView = [[GtTwitterUserHeaderView alloc] initWithFrame:CGRectMake(0,0,0, 50)];
	[self.contentView addSubview:m_headerView];
	
    self.textEditView.placeholderText = NSLocalizedString(@"What's happening?", nil);
	self.textEditView.frame = GtRectSetHeight(self.textEditView.frame, 80);
	[self.contentView addSubview:self.textEditView];
}

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[m_headerView beginLoadingInActionContext:self.actionContext userGuid:self.userGuid];
}

- (void) twitterAuthenticator:(GtTwitterAuthenticator*) authenticator didAuthenticateUser:(NSString*) userGuid
{
    UIViewController* newController = [GtNavigationControllerViewController navigationControllerViewController:self];
    if(DeviceIsPad())
    {
        GtHoverViewController* hoverView = [GtHoverViewController hoverViewController:newController];
        [hoverView presentInViewController:[GtHoverViewController defaultParentViewController]
            permittedArrowDirection:GtHoverViewControllerArrowDirectionNone
            fromPositionProvider:nil
            style:GtHoverViewStyleModal
            animated:YES];
    }
    else
    {
        self.modalParentViewController = authenticator.viewController;
        [authenticator.viewController presentModalViewController:newController animated:YES];
    }
}

- (void) twitterAuthenticator:(GtTwitterAuthenticator*) authenticator didFail:(NSError*) error
{
	[m_postDelegate twitterPostStatusViewController:self didFail:error];
}

- (void) twitterAuthenticatorWasCancelled:(GtTwitterAuthenticator*) authenticator
{
    [m_postDelegate twitterPostStatusViewControllerWasCancelled:self];
}

- (void) presentInViewController:(GtViewController*) viewController delegate:(id<GtTwitterPostStatusViewControllerDelegate>) delegate
{
	m_postDelegate = delegate;		
    
    GtTwitterAuthenticator* authenticator = [GtTwitterAuthenticator twitterAuthenticator];
    [authenticator beginAuthenticatingInViewController:viewController userGuid:self.userGuid delegate:self];
}

@end

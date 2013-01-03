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
#import "FLAlert.h"
#import "FLProgressViewController.h"
#import "FLSimpleProgressView.h"
#import "FLSingleColumnRowArrangement.h"
#import "FLArrangement.h"
#import "FLButtons.h"

@implementation FLTwitterPostStatusViewController

@synthesize statusUpdate = _statusUpdate;
@synthesize userGuid = _userGuid;

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
	return FLAutorelease([[FLTwitterPostStatusViewController alloc] initWithStatusUpdate:update userGuid:userGuid]);
}

- (void) dealloc
{
    FLRelease(_headerView);
	FLRelease(_userGuid);
	FLRelease(_statusUpdate);
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
    FLSetObjectWithRetain(_statusUpdate, statusUpdate);
    self.text = _statusUpdate.status;
}

- (void) viewDidUnload
{
    [super viewDidUnload];
    FLReleaseWithNil(_headerView);
}

- (void) presentTextIsTooLongMessage
{
    FLAlert* alert = [FLAlert alertViewController:NSLocalizedString(@"Your tweet is too long.", nil)
                                                                      message:[NSString stringWithFormat:(NSLocalizedString(@"The tweet length is 140 characters but yours is %d characters long.", nil)), self.textLength]];
    [alert addButton:[FLConfirmButton okButton]];
    [alert showViewControllerAnimated:YES];
}

- (void) beginSaving
{
	_statusUpdate.status = self.text;

	FLAction* action = [FLAction action];
    action.progressController = [FLProgressViewController progressViewController:[FLSimpleProgressView class]];
    action.actionDescription.actionItemName = NSLocalizedString(@"Status", nil);
    action.actionDescription.actionType = FLActionDescriptionTypeUpdate;
//	action.networkRequired = YES;

    FLTwitterPostStatusOperation* operation = [FLTwitterPostStatusOperation operation];
    [operation setTwitterSession:[[FLTwitterMgr instance] sessionForUserGuid:self.userGuid]];
    [operation setInput:_statusUpdate];
    [action addOperation:operation];
        
	[self startAction:action completion: ^(id result) {
        if([action didSucceed])
        {
            [_postDelegate twitterPostStatusViewController:self didPostStatus:_statusUpdate];
        }
        else
        {
            [_postDelegate twitterPostStatusViewController:self didFail:[action error]];
        }
    }];
}

- (void) beginCancel    
{
    [_postDelegate twitterPostStatusViewControllerWasCancelled:self];
}

- (void) configureContentView
{
    self.contentView.arrangement = [FLSingleColumnRowArrangement arrangement];
	self.contentView.arrangement.innerInsets = UIEdgeInsetsMake(0,0,10.0,0);
	self.contentView.arrangement.outerInsets = FLEdgeInsets10;

	_headerView = [[FLTwitterUserHeaderView alloc] initWithFrame:CGRectMake(0,0,0, 50)];
	[self.contentView addSubview:_headerView];
	
    self.textEditView.placeholderText = NSLocalizedString(@"What's happening?", nil);
	self.textEditView.frame = FLRectSetHeight(self.textEditView.frame, 80);
	[self.contentView addSubview:self.textEditView];
}

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[_headerView startLoadingInViewController:self userGuid:self.userGuid];
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
	[_postDelegate twitterPostStatusViewController:self didFail:error];
}

- (void) twitterAuthenticatorWasCancelled:(FLTwitterAuthenticator*) authenticator
{
    [_postDelegate twitterPostStatusViewControllerWasCancelled:self];
}

- (void) presentInViewController:(FLViewController*) viewController delegate:(id<FLTwitterPostStatusViewControllerDelegate>) delegate
{
	_postDelegate = delegate;		
    
    FLTwitterAuthenticator* authenticator = [FLTwitterAuthenticator twitterAuthenticator];
    [authenticator beginAuthenticatingInViewController:viewController userGuid:self.userGuid delegate:self];
}

@end

//
//  FLFacebookUserViewController.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/5/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLFacebookUserViewController.h"
#import "FLFacebookUser.h"
#import "FLWideSingleLineLabelAndValueCell.h"
#import "FLFacebookLoadUserOperation.h"

@implementation FLFacebookUserViewController

- (id) initWithUserId:(NSString*) userId
{
	if((self = [super init]))
	{
		m_userId = FLReturnRetained(userId);
		self.title = NSLocalizedString(@"Facebook User", nil);
		
	}

	return self;
}

- (void) dealloc
{
	FLRelease(m_userId);
	FLSuperDealloc();
}

- (void) doBeginLoadingObject
{
//	FLAction* action = [FLAction action];
//	[self.actionContext beginAction:action configureAction:^(id inAction) {
//		action.actionDescription.actionItemName = @"User";
//		action.actionDescription.actionType = FLActionDescriptionTypeLoad;
//
//		FLFacebookLoadUserOperation* operation = [[FLFacebookLoadUserOperation facebookLoadUserOperation]:[FLFacebookMgr instance].encodedToken userId:m_userId];
//		operation.cacheBehavior = FLHttpOperationCacheBehaviorAll;
//		operation.database = [FLFacebookMgr instance].userSession.cacheDatabase;
//		operation.wasLoadedFromCacheCallback = ^{
//			if(operation.didFinishWithoutError)
//			{
//				FLAssignObject(m_user, operation.output);
//				[self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
//			}
//		};
//		[action queueOperation:operation];
//		action.onFinished = ^(id theAction) {
//			if(action.didFinishWithoutError)
//			{
//				FLAssignObject(m_user, [[theAction lastOperation] operationOutput]);
//			}
//			
//			[self onDoneLoadingEditableData];
//		};
//	}];
}

- (void) doUpdateDataSourceManager:(FLLegacyDataSource*) dataSourceManager
{
	if(m_user)
	{
		[dataSourceManager setDataSource:m_user forKey:[FLFacebookUser dataSourceKey]];
	}
}

- (void) willConstructWithTableLayoutBuilder:(FLTableViewLayoutBuilder*) builder
{
	[builder addSection];
	
	[builder addCell:[FLWideSingleLineLabelAndValueCell wideSingleLineLabelAndValueCell:NSLocalizedString(@"Username", nil)] 
              forKey:[FLFacebookUser keyPathWithDataKey:[FLFacebookUser usernameKey]]];
}

@end

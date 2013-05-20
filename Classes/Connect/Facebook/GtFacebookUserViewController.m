//
//  GtFacebookUserViewController.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/5/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFacebookUserViewController.h"
#import "GtFacebookUser.h"
#import "GtWideSingleLineLabelAndValueCell.h"
#import "GtFacebookLoadUserOperation.h"

@implementation GtFacebookUserViewController

- (id) initWithUserId:(NSString*) userId
{
	if((self = [super init]))
	{
		m_userId = GtRetain(userId);
		self.title = NSLocalizedString(@"Facebook User", nil);
		
	}

	return self;
}

- (void) dealloc
{
	GtRelease(m_userId);
	GtSuperDealloc();
}

- (void) doBeginLoadingObject
{
//	GtAction* action = [GtAction action];
//	[self.actionContext beginAction:action configureAction:^(id inAction) {
//		action.actionDescription.itemName = @"User";
//		action.actionDescription.actionType = GtActionDescriptionTypeLoad;
//
//		GtFacebookLoadUserOperation* operation = [[GtFacebookLoadUserOperation facebookLoadUserOperation]:[GtFacebookMgr instance].encodedToken userId:m_userId];
//		operation.cacheBehavior = GtHttpOperationCacheBehaviorAll;
//		operation.database = [GtFacebookMgr instance].userSession.cacheDatabase;
//		operation.wasLoadedFromCacheCallback = ^{
//			if(operation.didFinishWithoutError)
//			{
//				GtAssignObject(m_user, operation.output);
//				[self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
//			}
//		};
//		[action queueOperation:operation];
//		action.didCompleteCallback = ^{
//			if(action.didFinishWithoutError)
//			{
//				GtAssignObject(m_user, [[action lastOperation] operationOutput]);
//			}
//			
//			[self onDoneLoadingEditableData];
//		};
//	}];
}

- (void) doUpdateDataSourceManager:(GtDataSourceManager*) dataSourceManager
{
	if(m_user)
	{
		[dataSourceManager setDataSource:m_user forKey:[GtFacebookUser dataSourceKey]];
	}
}

- (void) willConstructWithTableLayoutBuilder:(GtTableViewLayoutBuilder*) builder
{
	[builder addSection];
	
	[builder addCell:[GtWideSingleLineLabelAndValueCell wideSingleLineLabelAndValueCell:NSLocalizedString(@"Username", nil)] 
              forKey:[GtFacebookUser keyPathWithDataKey:[GtFacebookUser usernameKey]]];
}

@end

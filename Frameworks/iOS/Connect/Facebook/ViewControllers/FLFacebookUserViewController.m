//
//  FLFacebookUserViewController.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/5/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
		_userId = FLRetain(userId);
		self.title = NSLocalizedString(@"Facebook User", nil);
		
	}

	return self;
}

- (void) dealloc
{
	FLRelease(_userId);
	FLSuperDealloc();
}

- (void) doBeginLoadingObject
{
//	FLAction* action = [FLAction action];
//	[self.actionContext startAction:action configureAction:^(id inAction) {
//		action.actionDescription.actionItemName = @"User";
//		action.actionDescription.actionType = FLActionDescriptionTypeLoad;
//
//		FLFacebookLoadUserOperation* operation = [[FLFacebookLoadUserOperation facebookLoadUserOperation]:[FLFacebookMgr instance].encodedToken userId:_userId];
//		operation.cacheBehavior = FLHttpOperationCacheBehaviorAll;
//		operation.database = [FLFacebookMgr instance].userSession.cacheDatabase;
//		operation.wasLoadedFromCacheCallback = ^{
//			if(operation.didSucceed)
//			{
//				FLSetObjectWithRetain(_user, operation.output);
//				[self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
//			}
//		};
//		[action addOperation:operation];
//		action.willFinishBlock = ^(id theAction) {
//			if(action.didSucceed)
//			{
//				FLSetObjectWithRetain(_user, [[theAction lastOperation] operationOutput]);
//			}
//			
//			[self onDoneLoadingEditableData];
//		};
//	}];
}

- (void) doUpdateDataSourceManager:(FLLegacyDataSource*) dataSourceManager
{
	if(_user)
	{
		[dataSourceManager setDataSource:_user forKey:[FLFacebookUser dataSourceKey]];
	}
}

- (void) willConstructWithTableLayoutBuilder:(FLTableViewLayoutBuilder*) builder
{
	[builder addSection];
	
	[builder addCell:[FLWideSingleLineLabelAndValueCell wideSingleLineLabelAndValueCell:NSLocalizedString(@"Username", nil)] 
              forKey:[FLFacebookUser keyPathWithDataKey:[FLFacebookUser usernameKey]]];
}

@end

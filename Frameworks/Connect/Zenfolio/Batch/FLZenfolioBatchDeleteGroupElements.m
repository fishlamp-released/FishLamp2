//
//	FLZenfolioBatchDeleteGroupElements.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/24/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//
#if REFACTOR

#import "FLZenfolioBatchDeleteGroupElements.h"
#import "FLAction.h"

#import "FLReachableNetwork.h"

#if IOS
#import "NSObject+FLTheme.h"
#import "FLModalProgressView.h"
#import "FLAlert.h"
#import "FLButtons.h"
#import "FLProgressViewController.h"

#endif


@implementation FLZenfolioBatchDeleteGroupElements

- (void) _didDeleteGroupElement:(FLOperation*) operation
{
	if(operation.didSucceed)
	{
		FLZenfolioGroupElement* groupElement = self.currentQueueObject;
	
		FLZenfolioGroup* parentGroup = [FLZenfolioGroup loadFromCacheWithId:groupElement.parentGroupId.intValue];
		if(parentGroup)
		{
			[parentGroup removeGroupElement:groupElement];
			[parentGroup saveInCache];
		}
	
		[[[self.userContext userStorageService].cacheDatabase deleteObject:groupElement];
	}
}

- (void) _deleteWasApprovedByUser
{
#if IOS
	self.progressController = [FLProgressViewController progressViewController:[FLModalProgressView class] presentationBehavior:[FLModalPresentationBehavior instance]];
	[self.progressController setTitle:NSLocalizedString(@"Deleting:", nil)];
	[self.progressController setButtonTitle:NSLocalizedString(@"Cancel", nil)];
	[self.progressController setButtonTarget:self action:@selector(cancelCallback:) isCancel:YES];
	[self.progressController showProgress];
#endif
	[self didPrepareBatch];
}

- (void) prepareBatch
{
	if(![FLReachableNetwork instance].isReachable)
	{
		FLActionDescription* description = [[FLActionDescription alloc] init];
		description.actionType = FLActionTypeMove;
#if IOS
		ShowOfflineAlert(description.unableText);
#endif
        FLReleaseWithNil(description);
	
		[self requestCancel:nil];
	}
	else
	{
#if IOS
		FLAlert* alert = [FLAlert alertViewController:[NSString stringWithFormat:(NSLocalizedString(@"Really delete %d items?", nil)), self.totalActionCount]];
         
        alert.message = NSLocalizedString(@"All photos inside the deleted items will be permanently deleted. This operation cannot be undone.", nil);
        
        [alert addButton:[FLDenyButton cancelButton]];
        [alert addButton:[FLDeleteButton deleteButton:^(id controller) {
            [self _deleteWasApprovedByUser];
        } ]];
        
    	[alert showViewControllerAnimated:YES];
#endif
	}
}

- (void) updateProgress:(NSUInteger) count
    total:(NSUInteger) total
{
#if IOS
	[self.progressController updateProgress:count totalAmount:total];
	[((FLModalProgressView*)self.progressController.progressView) setProgressBarText:[NSString stringWithFormat:(NSLocalizedString(@"%d of %d Items", nil)), count + 1, total]];
#endif
}

- (FLAction*) createActionWithCurrentQueueObject:(id) object
{
	FLZenfolioGroupElement* groupElement = object;

	FLAction* action = FLAutorelease([[FLAction alloc] init]);	 
	
	action.networkRequired = YES;
	action.actionDescription.actionType = FLActionTypeDelete;

#if IOS
	[self.progressController setSecondaryText:groupElement.Title];
#endif

	if([groupElement isGroupElement])
	{		 
		FLZenfolioApiSoapDeleteGroup* groupOp = [[FLZenfolioApiSoapDeleteGroup alloc] initWithServerContext:[FLZenfolioApiSoap instance]];
		groupOp.input.groupId = groupElement.Id; 
        groupOp.willStartBlock = ^(id theOperation){ [self _didDeleteGroupElement:theOperation]; };
//		[groupOp setDidPerformCallback:self action:@selector(_didDeleteGroupElement:)];

		[action addOperation:groupOp];
		FLReleaseWithNil(groupOp);

		action.actionDescription.actionType = FLActionTypeDelete;
		action.actionDescription.actionItemName = FLActionDescriptionItemNameGroup;
	}
	else
	{
		FLZenfolioApiSoapDeletePhotoSet* psOp = [[FLZenfolioApiSoapDeletePhotoSet alloc] initWithServerContext:[FLZenfolioApiSoap instance]];
		psOp.input.photoSetId = groupElement.Id; 
        psOp.willStartBlock = ^(id theOperation) { [self _didDeleteGroupElement:theOperation]; };
//		[psOp setDidPerformCallback:self action:@selector(_didDeleteGroupElement:)];
		[action addOperation:psOp];
		FLReleaseWithNil(psOp);

		action.actionDescription.actionItemName = [groupElement isGalleryElement] ? FLActionDescriptionItemNameGallery : FLActionDescriptionItemNameCollection;
	}

	return action;
}

@end
#endif
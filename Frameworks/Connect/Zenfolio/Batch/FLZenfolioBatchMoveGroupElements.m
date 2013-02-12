//
//	FLZenfolioBatchMoveGroupElements.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/24/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//
#if REFACTOR

#import "FLZenfolioBatchMoveGroupElements.h"
#import "FLReachableNetwork.h"


#if IOS
#import "FLProgressViewController.h"
#import "FLModalProgressView.h"
#endif

@implementation FLZenfolioBatchMoveGroupElements

@synthesize destinationGroup = _destGroup;
@synthesize parentGroup = _parentGroup;

- (void) dealloc
{
	FLRelease(_destGroup);
	FLRelease(_parentGroup);
	FLSuperDealloc();
}

- (void) updateCacheAfterMoving:(FLOperation*) operation
{
	if(operation.didSucceed)
	{
		FLZenfolioGroupElement* groupElement = self.currentQueueObject;
	
		[_parentGroup removeGroupElement:groupElement];
		[_parentGroup saveInCache];
		
		[_destGroup addGroupElement:groupElement];
		[_destGroup saveInCache];
	}
}

- (void) prepareBatch
{
#if IOS
	self.progressController = [FLProgressViewController progressViewController:[FLModalProgressView class] presentationBehavior:[FLModalPresentationBehavior instance]];
    
//    [self.progressController setWasThemed:YES];
	[self.progressController setTitle:NSLocalizedString(@"Moving:", nil)];
	[self.progressController setButtonTitle:NSLocalizedString(@"Cancel", nil)];
	[self.progressController setButtonTarget:self action:@selector(cancelCallback:) isCancel:YES];
    [self.progressController showProgress];
#endif

	[self didPrepareBatch];
}

- (void) updateProgress:(NSUInteger) count
    total:(NSUInteger) total
{
#if IOS
	[self.progressController updateProgress:count totalAmount:total];

// TODO: fix this - is this the right text to set?
	[self.progressController setSecondaryText:[NSString stringWithFormat:(NSLocalizedString(@"%d of %d Items", nil)), 
		count + 1, 
		total]];
#endif
}

- (FLAction*) createActionWithCurrentQueueObject:(id) object
{
	FLZenfolioGroupElement* groupElement = object;

	[self.progressController setSecondaryText:groupElement.Title];

	FLAction* action = FLAutorelease([[FLAction alloc] init]);
	action.networkRequired = YES;
	action.actionDescription.actionType = FLActionTypeMove;
	
	if([groupElement isGroupElement])
	{
		FLZenfolioApiSoapMoveGroup* moveGroup = [[FLZenfolioApiSoapMoveGroup alloc] initWithServerContext:[FLZenfolioApiSoap instance]];
		moveGroup.input.groupId = groupElement.Id;
		moveGroup.input.destGroupId = _destGroup.Id;
		moveGroup.input.index = _destGroup.SubGroupCount;
		moveGroup.willStartBlock = ^(id theOperation) {
            [self updateCacheAfterMoving:theOperation];
            };
        
//        [moveGroup setDidPerformCallback:self action:@selector(updateCacheAfterMoving:)];
		[action addOperation:moveGroup];
		FLReleaseWithNil(moveGroup);
		
		action.actionDescription.actionItemName = FLActionDescriptionItemNameGroup;
	}
	else
	{
		FLZenfolioApiSoapMovePhotoSet* moveGallery = [[FLZenfolioApiSoapMovePhotoSet alloc] initWithServerContext:[FLZenfolioApiSoap instance]];
		moveGallery.input.photoSetId = groupElement.Id;
		moveGallery.input.destGroupId = _destGroup.Id;
		moveGallery.input.index = _destGroup.SubGroupCount;
//		[moveGallery setDidPerformCallback:self action:@selector(updateCacheAfterMoving:)];
		moveGallery.willStartBlock = ^(id theOperation) {
            [self updateCacheAfterMoving:theOperation];
            };

		[action addOperation:moveGallery];
		FLReleaseWithNil(moveGallery);
		
		action.actionDescription.actionType = FLActionTypeMove;
		action.actionDescription.actionItemName = [groupElement isGalleryElement] ? FLActionDescriptionItemNameGallery : FLActionDescriptionItemNameCollection;
	}
		
	return action;
}

@end
#endif
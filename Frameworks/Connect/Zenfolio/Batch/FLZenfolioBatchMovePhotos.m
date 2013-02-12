//
//	FLBatchMovePhotos.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/25/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//
#if REFACTOR

#import "FLZenfolioBatchMovePhotos.h"
#import "FLReachableNetwork.h"



#if IOS
#import "FLProgressViewController.h"
#import "FLModalProgressView.h"
#endif

@implementation FLZenfolioBatchMovePhotos

@synthesize sourcePhotoSet = _parentPhotoSet;
@synthesize destPhotoSet = _destPhotoSet;

- (void) dealloc
{
	FLRelease(_parentPhotoSet);
	FLRelease(_destPhotoSet);
	FLSuperDealloc();
}

- (void) didPrepareBatch
{
#if IOS
	self.progressController = [FLProgressViewController progressViewController:[FLModalProgressView class] presentationBehavior:[FLModalPresentationBehavior instance]];
	[self.progressController setTitle:NSLocalizedString(@"Moving:", nil)];
	[self.progressController setButtonTitle:NSLocalizedString(@"Cancel", nil)];
	[self.progressController setButtonTarget:self action:@selector(cancelCallback:) isCancel:YES];
	[self.progressController showProgress];
#endif
	[super didPrepareBatch];
}

- (void) _updateCacheAfterMove:(FLOperation*) operation
{
	if(operation.didSucceed)
	{
		FLZenfolioPhoto* photo = self.currentQueueObject;
		
		_destPhotoSet.PhotoCountValue = _destPhotoSet.PhotoCountValue + 1;
		[_destPhotoSet addPhoto:photo];
		[_destPhotoSet saveInCache];
					
		// delete the photo if it's coming from a gallery			 
		if(_parentPhotoSet && _parentPhotoSet.isGalleryElement)
		{
			[_parentPhotoSet removePhoto:photo forceCountDecrement:YES];
			[_parentPhotoSet saveInCache];
		}
	}
}

- (void) updateProgress:(NSUInteger) count
    total:(NSUInteger) total
{
	[self.progressController updateProgress:count totalAmount:total];
	
#if IOS
	[self.progressController setSecondaryText:[NSString stringWithFormat:(NSLocalizedString(@"%d of %d Items", nil)),
		count + 1, 
		total]];
#endif
}

- (FLAction*) createActionWithCurrentQueueObject:(id) object {
	FLZenfolioPhoto* photo = object;
	
	[self.progressController setSecondaryText:photo.displayName];

	FLAction* action = FLAutorelease([[FLAction alloc] init]);
	action.networkRequired = YES;
	action.actionDescription.actionItemName = FLActionDescriptionItemNamePhoto;
	
	
	if(_destPhotoSet.TypeValue == FLZenfolioPhotoSetTypeGallery)
	{
		FLZenfolioApiSoapMovePhoto* moveOp = [[FLZenfolioApiSoapMovePhoto alloc] initWithServerContext:[FLZenfolioApiSoap instance]];
		moveOp.input.srcSetId = _parentPhotoSet.Id;
		moveOp.input.photoId = photo.Id;
		moveOp.input.destSetId = _destPhotoSet.Id;
		moveOp.input.index = _destPhotoSet.PhotoCount;
//		[moveOp setDidPerformCallback:self action:@selector(_updateCacheAfterMove:)];
        moveOp.willStartBlock = ^(id theOperation) { [self _updateCacheAfterMove:theOperation]; };
		[action addOperation:moveOp];
		FLReleaseWithNil(moveOp);
		
		action.actionDescription.actionType = FLActionTypeMove;
	}
	else
	{
		FLZenfolioApiSoapCollectionAddPhoto* addToCollection = [[FLZenfolioApiSoapCollectionAddPhoto alloc] initWithServerContext:[FLZenfolioApiSoap instance]];
		addToCollection.input.collectionId = _destPhotoSet.Id;
		addToCollection.input.photoId = photo.Id;
        addToCollection.willStartBlock = ^(id theOperation) { [self _updateCacheAfterMove:theOperation]; };
//		[addToCollection setDidPerformCallback:self action:@selector(_updateCacheAfterMove:)];

		[action addOperation:addToCollection];
		FLReleaseWithNil(addToCollection);
		
		action.actionDescription.actionType = FLActionTypeAdd;
		action.actionDescription.actionItemName = FLActionDescriptionItemNamePhoto;
	}
			
	return action;
}
@end
#endif
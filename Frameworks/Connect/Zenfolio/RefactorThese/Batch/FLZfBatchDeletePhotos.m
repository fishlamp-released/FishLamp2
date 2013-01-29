//
//	FLBatchDeletePhotos.m
//	MyZen
//
//	Created by Mike Fullerton on 2/25/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//
#if REFACTOR
#import "FLZfBatchDeletePhotos.h"
#import "FLAction.h"
#import "FLZfUtils.h"

#if IOS
#import "NSObject+FLTheme.h"
#import "FLAlert.h"
#import "FLButtons.h"
#import "FLModalProgressView.h"
#import "FLProgressViewController.h"
#endif

@implementation FLZfBatchDeletePhotos

@synthesize photoSet = _photoSet;

- (void) dealloc
{
	FLRelease(_photoSet);
	FLSuperDealloc();
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
#if IOS

	if(![FLReachableNetwork instance].isReachable)
	{
		FLActionDescription* description = [[FLActionDescription alloc] init];
		description.actionType = FLActionTypeDelete;
		ShowOfflineAlert(description.unableText);
		FLReleaseWithNil(description);
	
		[self requestCancel:nil];
	}
	else
	{
		NSString* removeStr = _photoSet.isGalleryElement ? NSLocalizedString(@"Delete", nil) : NSLocalizedString(@"Remove", nil);
	
		FLAlert* alert = [FLAlert alertViewController:[NSString stringWithFormat:(NSLocalizedString(@"Really %@ %d photos?", nil)), removeStr, self.totalActionCount]];
          
		alert.message = _photoSet.isGalleryElement ?   
            NSLocalizedString(@"These photos will be permanently deleted.\n\nThis operation cannot be undone.", nil) : 
            NSLocalizedString(@"These photos will be removed from the Collection but not deleted from parent Gallery.", nil);
            
        [alert addButton:[FLDenyButton cancelButton]];
        [alert addButton:[FLDeleteButton deleteButton:^(id sender) {
                [self _deleteWasApprovedByUser];
            }]];
            	
        [alert showViewControllerAnimated:YES];
	}
#endif
}

- (void) onUpdateCacheAfterDeletedPhoto:(FLOperation*) operation
{
	if(operation.didSucceed)
	{
		FLZfPhoto* photo = self.currentQueueObject;
		[_photoSet removePhoto:photo forceCountDecrement:YES];
		[_photoSet saveInCache];
	}
}

- (void) updateProgress:(NSUInteger) count
    total:(NSUInteger) total
{
	[self.progressController updateProgress:count totalAmount:total];

#if IOS
	[self.progressController.progressView setProgressBarText:[NSString stringWithFormat:(NSLocalizedString(@"%d of %d Photos", nil)),
		count + 1, 
		total]];
#endif
}


- (FLAction*) createActionWithCurrentQueueObject:(id) object
{
	FLZfPhoto* photo = object;

	
	[self.progressController setSecondaryText:photo.displayName];
			
	FLAction* action = FLAutorelease([[FLAction alloc] init]);
	action.networkRequired = YES;
	action.actionDescription.actionItemName = FLActionDescriptionItemNamePhoto;
	
	FLZfPhotoSetType type = _photoSet.TypeValue;
	if(type == FLZfPhotoSetTypeGallery)
	{
		FLZfApiSoapDeletePhoto* operation = [[FLZfApiSoapDeletePhoto alloc] initWithServerContext:[FLZfApiSoap instance]];
		operation.input.photoId = [photo Id];
        operation.willStartBlock = ^(id theOperation) { [self onUpdateCacheAfterDeletedPhoto:theOperation]; };
//		[operation setDidPerformCallback:self action:@selector(onUpdateCacheAfterDeletedPhoto:)];

		[action addOperation:operation];
		FLReleaseWithNil(operation);
		
		action.actionDescription.actionType = FLActionTypeDelete;
	}
	else
	{
		FLZfApiSoapCollectionRemovePhoto* operation = [[FLZfApiSoapCollectionRemovePhoto alloc] initWithServerContext:[FLZfApiSoap instance]];
		operation.input.collectionId = _photoSet.Id;
		operation.input.photoId = [photo Id];
        operation.willStartBlock = ^(id theOperation) { [self onUpdateCacheAfterDeletedPhoto:theOperation]; };
///		[operation setDidPerformCallback:self action:@selector(onUpdateCacheAfterDeletedPhoto:)];
		
		[action addOperation:operation];
		FLReleaseWithNil(operation);
		
		action.actionDescription.actionType = FLActionTypeRemove;
	}

	return action;
}

@end
#endif
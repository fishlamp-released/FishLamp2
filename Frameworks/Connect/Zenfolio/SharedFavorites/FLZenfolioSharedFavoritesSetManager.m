//
//	FLZenfolioFavoritesSetManager.m
//	FishLamp
//
//	Created by Mike Fullerton on 1/11/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#if REFACTOR

#import "FLZenfolioSharedFavoritesSetManager.h"
#import "FLZenfolioPresentationModeOptions.h"
#import "FLAction.h"
#import "FLReachableNetwork.h"
#import "FLErrorDescriber.h"
#import "NSString+GUID.h"

#import "FLDatabase.h"

#if IOS
#import "FLButtons.h"
#import "FLProgressViewController.h"
#import "FLAlert.h"
#import "FLOldUserNotificationView.h"
#import "FLModalProgressView.h"
#endif


@implementation FLZenfolioSharedFavoritesSetManager

FLSynthesizeSingleton(FLZenfolioSharedFavoritesSetManager);

- (void) saveSharedFavoritesSet:(FLZenfolioSharedFavoritesSet*) set
{
	if(FLStringIsEmpty(set.sharedFavoritesSetId))
	{
		set.sharedFavoritesSetId = [NSString guidString];
	}

	[[[self.context userStorageService] documentsDatabase] saveObject:set];
}

- (NSArray*) loadAllSharedFavorites
{
	NSArray* array = nil;
	
	if([[[self.context userStorageService] documentsDatabase] rowCountForTable:[[FLZenfolioSharedFavoritesSet class] sharedDatabaseTable]] > 0)
	{
		[[[self.context userStorageService] documentsDatabase] loadAllObjectsForTypeWithClass:[FLZenfolioSharedFavoritesSet class] outObjects:&array];
        FLAutorelease(array);
	}
	
	return array;
}

#if IOS
- (void) discardFailedSet:(FLAlert*)alert
{
}

- (void) tryAgain:(FLAlert*)alert
{
}
#endif

- (void) _didUploadFavoritesSets:(FLZenfolioSaveAllSharedFavorites*) batchAction
{
#if IOS
	if(batchAction.error)
	{
		NSString* errorString = [[FLErrorDescriberManager instance] describeError:batchAction.error];
	
		FLAlert* errorAlert = [FLAlert alertViewController:[NSString stringWithFormat:NSLocalizedString(@"Problem Saving Shared Favorites Set: %@", nil), batchAction.lastSharedFavorite.favoritesSetName]];
        
        errorAlert.message = errorString;
        
		[errorAlert addButton:[FLDenyButton buttonWithTitle:NSLocalizedString(@"Discard Set", nil)
                      onPress:^(id controller) {
                          [[[self.context userStorageService] documentsDatabase] deleteObject:[batchAction lastSharedFavorite]];
                      }]];

		[errorAlert addButton:[FLConfirmButton buttonWithTitle:NSLocalizedString(@"Try Again", nil)
                      onPress:^(id controller) {
                          [self uploadSavedFavoritesSetsIfNeeded:[batchAction actionContext]];
                      }]];

        [errorAlert showViewControllerAnimated:YES];
	}
	
	if(batchAction.completedActionCount > 0)
	{
		FLOldUserNotificationView* view = FLAutorelease([[FLOldUserNotificationView alloc] initAsInfoNotification]);
		view.title = [NSString stringWithFormat:NSLocalizedString(@"%d Favorite Sets were uploaded to the server.", nil), batchAction.completedActionCount];
		[view showNotification];
	}
#endif
}

- (void) uploadSavedFavoritesSetsIfNeeded:(FLOperationContext*) actionContext
{
	if([FLReachableNetwork instance].isReachable)
	{
		NSArray* favoriteSets = [self loadAllSharedFavorites];
		if(favoriteSets)
		{
            FLZenfolioSaveAllSharedFavorites* action = [FLZenfolioSaveAllSharedFavorites batchActionManager];
            
            [action setQueuedDataForBatch:favoriteSets];
			[actionContext startAction:action completion: ^(id<FLAsyncResult> result) {
                [self _didUploadFavoritesSets:action];
                }];
		}
	}
}

@end

@implementation FLZenfolioSaveAllSharedFavorites

@synthesize showProgress = _showProgress;
@synthesize lastSharedFavorite = _lastSharedFavorite;

- (void) _finishedUploadingFavoritesSet:(FLZenfolioApiSoapShareFavoritesSet*) share
{
	if(share.didSucceed)
	{
		[[[self.context userStorageService] documentsDatabase] deleteObject:[self currentQueueObject]];
	}
}

- (void) prepareBatch
{
#if IOS
	if(self.showProgress)
	{
    	self.progressController = [FLProgressViewController progressViewController:[FLModalProgressView class] presentationBehavior:[FLModalPresentationBehavior instance]];
//		[self.progressController setWasThemed:YES];
		[self.progressController setTitle:NSLocalizedString(@"Uploading Shared Favorites:", nil)];
		[self.progressController setButtonTitle:NSLocalizedString(@"Cancel", nil)];
		[self.progressController setButtonTarget:self action:@selector(cancelCallback:) isCancel:YES];
		[self.progressController showProgress];
	}
#endif
	[self didPrepareBatch];
}

- (void) _willBeginToShareFavoriteSet:(FLZenfolioApiSoapShareFavoritesSet*) share
{
	FLZenfolioApiSoapCreateFavoritesSet* previous = (FLZenfolioApiSoapCreateFavoritesSet*) share.previousOperation;
	share.input.favoritesSetIdValue = previous.output.CreateFavoritesSetResultValue;
}

- (void) updateProgress:(NSUInteger) count
    total:(NSUInteger) total
{
	[self.progressController updateProgress:count totalAmount:total];
#if IOS
	[self.progressController.progressView setProgressBarText:[NSString stringWithFormat:(NSLocalizedString(@"%d of %d Shared Favorites", nil)), 
		count + 1, 
		total]];
#endif
}

- (FLAction*) createActionWithCurrentQueueObject:(FLZenfolioSharedFavoritesSet*) set
{
	FLSetObjectWithRetain(_lastSharedFavorite, set);

	FLAction* action = [FLAction action];
	action.disableErrorNotifications = YES;
	
	if(self.progressController)
    {
		[self.progressController setSecondaryText:set.favoritesSetName];
	}
	
	FLZenfolioApiSoapCreateFavoritesSet* createSet = [FLZenfolioApiSoapCreateFavoritesSet networkOperationWithServerContext:[FLZenfolioApiSoap instance]]; 
	createSet.input.name = set.favoritesSetName;
	createSet.input.photographerLogin = [self.context userService].userLogin.userName;
	createSet.input.photoIds = FLAutorelease([[set.photoIds allObjects] mutableCopy]);
	[action addOperation:createSet];
	
	FLZenfolioApiSoapShareFavoritesSet* shareFaves = [FLZenfolioApiSoapShareFavoritesSet networkOperationWithServerContext:[FLZenfolioApiSoap instance]];
	shareFaves.input.favoritesSetName = set.favoritesSetName;
	shareFaves.input.sharerName = set.sharerName;
	shareFaves.input.sharerMessage = set.sharerMessage;
	shareFaves.input.sharerEmail = [self.context userService].userLogin.email;
	shareFaves.input.sharerName = [self.context userService].userLogin.userName;

    shareFaves.willStartBlock = ^(id theOperation) { 
        [self _willBeginToShareFavoriteSet:theOperation]; 
    };

    shareFaves.willStartBlock = ^(id theOperation) { 
        [self _finishedUploadingFavoritesSet:theOperation]; 
    };

	[action addOperation:shareFaves];
	
	action.actionDescription.actionType = FLActionTypeSave;
	action.actionDescription.actionItemName = NSLocalizedString(@"Favorites Set",nil);
	return action;
}

- (void) dealloc
{
	FLRelease(_lastSharedFavorite);
	FLSuperDealloc();
}

@end
#endif
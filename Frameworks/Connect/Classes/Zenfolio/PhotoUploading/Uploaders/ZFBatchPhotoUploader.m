//
//  ZFBatchPhotoUploader.m
//  FishLamp
//
//  Created by Mike Fullerton on 8/31/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//
#if REFACTOR

#import "ZFBatchPhotoUploader.h"
#import "ZFUploadQueue.h"
#import "FLTempFileMgr.h"


#import "FLStringUtils.h"
#import "FLDisplayFormatters.h"

#if IOS
#import "FLProgressViewController.h"
#import "FLModalProgressView.h"
#endif

@implementation ZFBatchPhotoUploader

- (void) _updateProgressWhileUploadingImage:(unsigned long long) amountWritten
    totalAmountWritten:(unsigned long long) totalAmountWritten
    totalAmountExpectedToWrite:(unsigned long long) totalAmountExpectedToWrite
{
	self.bytesUploaded += amountWritten;

    // size is determined by adding up all the file sizes 
}

- (void) createProgress:(FLRectLayout) progressLocation
{
#if IOS
    self.progressController =
        [FLProgressViewController progressViewController:[FLModalProgressView class] presentationBehavior:[FLModalPresentationBehavior instance]];
#endif
    [super createProgress:progressLocation];
}

- (NSSet*) uploadGalleries
{
	ZFUploadGallery* defaultUploadGallery = [ZFUploadGallery defaultUploadGallery];

	NSMutableSet* photoSets = [NSMutableSet set];

	for(ZFQueuedPhoto* photo in self.uploadQueue)
	{
		if(!photo.hasUploadGallery)
		{
			photo.uploadGallery = defaultUploadGallery;
		}
	   
		if(!photo.hasUploadGallery)
		{
			return nil; // will call back into delegate with error
		}
		
		[photoSets addObject:photo.uploadDestinationId];
	}
    
    return photoSets;
}

- (void) _handleInitState
{
    _totalPhotosInQueue = self.uploadQueue.count;
    _uploadCount = 0;

    [super _handleInitState];
}

- (void) _handleBeginUploadState
{
    self.imageFile = nil;
    self.photo = nil;
   
    ++_uploadCount;
	
    self.photo = [self.uploadQueue assetAtIndex:0];
    [self.progressController setTitle:NSLocalizedString(@"Uploading Photo:", nil)];
    [self.progressController setSecondaryText:self.photo.displayName];
    [self _updateProgress];
    [super _handleBeginUploadState];
}

- (ZFPhotoUploaderState) nextStateForState:(ZFPhotoUploaderState) state
{
    if(state == ZFPhotoUploaderStateUploadMetadata)
    {
        if(_uploadCount < _totalPhotosInQueue)
        {
            return ZFPhotoUploaderStateBeginUpload;
        }
        else
        {
            return ZFPhotoUploaderStateDone;
        }
    }
    
    return [super nextStateForState:state];
}

- (unsigned long long) calculateInitialUploadSize
{
    unsigned long long outSize = 0;

	for(ZFQueuedPhoto* photo in self.uploadQueue)
	{
		outSize += photo.imageAsset.original.sizeInStorage;
	}

    return outSize;
}

- (void) _updateProgress
{
    [super _updateProgress];

#if IOS
    [self.progressController.progressView setProgressBarText:[NSString stringWithFormat:(NSLocalizedString(@"%d (%@) of %d (%@) Photos", nil)),
        _uploadCount, 
        FLStringFromByteSize(self.bytesUploaded),
        _totalPhotosInQueue,
        FLStringFromByteSize(self.uploadSize)
        ]];
#endif
}


@end
#endif

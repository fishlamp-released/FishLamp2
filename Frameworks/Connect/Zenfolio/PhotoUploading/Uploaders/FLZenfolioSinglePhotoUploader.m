//
//  FLZenfolioSinglePhotoUploader.m
//  FishLamp
//
//  Created by Mike Fullerton on 8/31/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//

#if REFACTOR

#import "FLZenfolioSinglePhotoUploader.h"

#import "FLStringUtils.h"
#import "FLDisplayFormatters.h"

#if IOS
#import "FLProgressViewController.h"
#import "FLModalProgressView.h"
#import "FLSmallProgressView.h"
#endif

@implementation FLZenfolioSinglePhotoUploader

FLAssertDefaultInitNotCalled_();

- (id) initWithPhoto:(FLZenfolioQueuedPhoto*) photo uploadQueue:(FLZenfolioUploadQueue*) uploadQueue
{
    FLAssertIsNotNil_(photo);

	if((self = [super initWithUploadQueue:uploadQueue]))
	{
        self.photo = photo;
	}
	
	return self;
}

- (void) _updateProgressWhileUploadingImage:(unsigned long long) amountWritten
    totalAmountWritten:(unsigned long long) totalAmountWritten
    totalAmountExpectedToWrite:(unsigned long long) totalAmountExpectedToWrite
{
	self.bytesUploaded = totalAmountWritten;
    self.uploadSize = totalAmountExpectedToWrite; // this will always be correct size.
}

- (NSSet*) uploadGalleries
{
    if(!self.photo.hasUploadGallery)
    {
        self.photo.uploadGallery = [FLZenfolioUploadGallery defaultUploadGallery];
        [self.uploadQueue.database writeObject:self.photo];
    }
    if(!self.photo.hasUploadGallery)
    {
        return nil;
    }

    return [NSSet setWithObject:self.photo.uploadDestinationId];
}

- (void) createProgress:(FLRectLayout) progressLocation
{
#if IOS
	if(DeviceIsPad())
	{
        self.progressController = [FLProgressViewController progressViewController:[FLModalProgressView class] presentationBehavior:[FLModalPresentationBehavior instance]];
	}
	else
	{
        self.progressController = [FLProgressViewController progressViewController:[FLSmallProgressView class]];

		
#if VIEW_AUTOLAYOUT
		[self.progressController setSuperviewContentsDescriptor:FLViewContentsDescriptorNone];
#endif        
	}

    [super createProgress:progressLocation];
    
    [self.progressController setTitle:[NSString stringWithFormat:(NSLocalizedString(@"Uploading: %@", nil)), self.photo.displayName]];
    
#endif
}

- (unsigned long long) calculateInitialUploadSize
{
    return self.photo.imageAsset.original.sizeInStorage;
}

- (void) _updateProgress
{
    [super _updateProgress];
#if IOS
    
    [self.progressController.progressView setProgressBarText:[NSString stringWithFormat:(NSLocalizedString(@"%@ of %@", nil)),
        FLStringFromByteSize(self.bytesUploaded),
        FLStringFromByteSize(self.uploadSize)
        ]];
#endif
}

@end
#endif
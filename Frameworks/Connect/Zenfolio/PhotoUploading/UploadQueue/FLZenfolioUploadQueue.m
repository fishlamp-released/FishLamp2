//
//  FLZenfolioUploadQueue.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/13/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLZenfolioUploadQueue.h"
//#import "FLZenfolioPreferences.h"

#import "NSString+Guid.h"
#import "FLZenfolioUploadablePhoto.h"
#import "ISO8601DateFormatter.h"

#import "FLUserDataStorageService+ZenfolioAdditions.h"

#import "FLJpegFileImageAsset.h"

#if REFACTOR
//#if IOS
#import "FLAssetsLibraryImageAsset.h"
#endif

#import "FLHtmlStringBuilder.h"
#import "FLUserDataStorageService.h"
//#import "FLZenfolioPrefsService.h"

#if 0
#define TRACE DEBUG
#endif

NSString* const FLZenfolioUploadQueueDidChangeNotification = @"FLZenfolioUploadQueueDidChangeNotification";

@implementation FLZenfolioUploadQueue

@synthesize delegate = _delegate;

- (id) init {
	if((self = [super initWithQueueUID:[NSString zeroGuidString]])) {
    }
	
	return self;
}

+ (id) uploadQueue {
    return FLAutorelease([[[self class] alloc] init]);
}

- (Class) queueClass {
	return [FLZenfolioQueuedPhoto class];
}

- (void) addImageAsset:(id<FLImageAsset>) photo 
             assetType:(FLAssetType) assetType
         uploadGallery:(FLZenfolioUploadGallery*) uploadGalleryOrNil
{
	FLZenfolioQueuedPhoto* img = [[FLZenfolioQueuedPhoto alloc] initWithImageAsset:photo assetType:assetType];
	if(uploadGalleryOrNil)
	{
		img.uploadGallery = uploadGalleryOrNil;
	}
	
	[self addAsset:img];
	FLReleaseWithNil(img);
}

- (void) addAssetsFromAssetsBrowser:(NSArray*) assets 
                      uploadGallery:(FLZenfolioUploadGallery*) uploadGalleryOrNil
{
	NSMutableArray* newAssets = [NSMutableArray arrayWithCapacity:assets.count];
	for(id<FLImageAsset> asset in assets)
	{
		FLZenfolioQueuedPhoto* newPhoto = [[FLZenfolioQueuedPhoto alloc] initWithImageAsset:asset
			assetType:FLAssetTypeImageFromAssetsLibrary];
		if(uploadGalleryOrNil)
		{
			newPhoto.uploadGallery = uploadGalleryOrNil;
		}
		[newAssets addObject:newPhoto];
		FLRelease(newPhoto);
	}

	[self batchAddAssets:newAssets];
}

- (void) changeUploadGalleriesTo:(FLZenfolioUploadGallery*) gallery 
                  forMissingOnly:(BOOL) forMissingOnly
{
	FLAssertIsNotNil(gallery);

	FLAssertIsNotNil(self.database);

	NSMutableArray* saveList = [NSMutableArray array]; 
	for(FLZenfolioQueuedPhoto* asset in self)
	{
		if(!forMissingOnly || !asset.hasUploadGallery)
		{
			asset.uploadGallery = gallery;
			
			[saveList addObject:asset];
		}
	}

	[self.database batchWriteObjects:saveList];
}

- (BOOL) photosNeedUploadGallery
{
	for(FLZenfolioQueuedPhoto* asset in self)
	{
		if(!asset.hasUploadGallery)
		{
			return YES;
		}
	}

	return NO;
}

- (void) updateItemsToDefaultUploadGalleryIfNeeded
{
    FLZenfolioUploadGallery* defaultUploadGallery = nil; 
    
	FLAssertIsNotNil(self.database);

	NSMutableArray* saveList = nil; 
	for(FLZenfolioQueuedPhoto* asset in self)
	{
		if(!asset.hasUploadGallery)
		{
            if(!defaultUploadGallery)
            {
                defaultUploadGallery = [self.delegate defaultUploadGallery];
                
                if(!defaultUploadGallery)
                {
                    return; // never mind
                }
            }
            
            asset.uploadGallery = defaultUploadGallery;
			
			if(!saveList)
            {
                saveList = [NSMutableArray array];
            }
            
            [saveList addObject:asset];
		}
	}

    if(saveList)
    {
        [self.database batchWriteObjects:saveList];
    }
}



- (void) _updateAsset:(FLZenfolioQueuedPhoto*) photo
           fileNumber:(NSUInteger) fileNumber
{
	FLAssertIsNotNil(self.database);

	FLZenfolioUploadGallery* gallery = [self.delegate defaultUploadGallery];
	FLZenfolioAccessDescriptor* accessDesc = [self.delegate defaultAccessDescriptor];

	photo.scaledUploadSize = self.delegate.defaultUploadSize;

#if IOS
	if(photo.assetTypeValue == FLAssetTypeImageFromCamera) {
		photo.saveToDeviceBeforeUpload = self.delegate.saveToDeviceBeforeUpload;
	}
#endif
    
	photo.accessDescriptor = accessDesc;
	
	if(!photo.hasUploadGallery) {
		photo.uploadGallery = gallery;
	}

	if(FLStringIsEmpty(photo.assetFileName)) {
		photo.assetFileName = [NSString stringWithFormat:@"IMG_%04u.JPG", (int) fileNumber];
	}
	
FIXME("asset stuff")

//	id<FLImageAsset> img = photo.imageAsset;
//	if(img.original.canWriteToStorage && !img.original.existsInStorage)
//	{
//		[img.original writeToStorage];
//	}
}

- (void) batchAddAssets:(NSArray*) assets {
	FLAssertIsNotNil(self.database);

	NSUInteger fileCount = self.totalAssetsAdded;
		
	for(FLZenfolioQueuedPhoto* photo in assets) {
		[self _updateAsset:photo fileNumber:++fileCount];
	}
	
	[super batchAddAssets:assets];
}

- (void) addAsset:(FLZenfolioQueuedPhoto*) photo {
	[self _updateAsset:photo fileNumber:self.totalAssetsAdded + 1];
	[super addAsset:photo];
}


- (void) _postChangeNotification
{
#if IOS
    [UIApplication sharedApplication].applicationIconBadgeNumber = self.count;
#endif
    [[NSNotificationCenter defaultCenter] postNotification:
        [NSNotification notificationWithName:FLZenfolioUploadQueueDidChangeNotification object:nil]];
}

- (void) didChangeAssetQueue
{
    [super didChangeAssetQueue];
    [self performSelectorOnMainThread:@selector(_postChangeNotification) withObject:nil waitUntilDone:NO];
}

@end





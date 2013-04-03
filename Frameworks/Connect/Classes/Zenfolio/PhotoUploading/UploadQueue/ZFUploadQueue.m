//
//  ZFUploadQueue.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/13/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//
#if REFACTOR

#import "ZFUploadQueue.h"
//#import "ZFPreferences.h"

#import "NSString+Guid.h"
#import "ZFUploadablePhoto.h"
#import "ISO8601DateFormatter.h"

#import "FLUserDataStorageService+ZenfolioAdditions.h"

#import "FLJpegFileImageAsset.h"

#if REFACTOR
//#if IOS
#import "FLAssetsLibraryImageAsset.h"
#endif

#import "FLHtmlStringBuilder.h"
#import "FLUserDataStorageService.h"
//#import "ZFPrefsService.h"

#if 0
#define TRACE DEBUG
#endif

NSString* const ZFUploadQueueDidChangeNotification = @"ZFUploadQueueDidChangeNotification";

@implementation ZFUploadQueue

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
	return [ZFQueuedPhoto class];
}

- (void) addImageAsset:(id<FLImageAsset>) photo 
             assetType:(FLAssetType) assetType
         uploadGallery:(ZFUploadGallery*) uploadGalleryOrNil
{
	ZFQueuedPhoto* img = [[ZFQueuedPhoto alloc] initWithImageAsset:photo assetType:assetType];
	if(uploadGalleryOrNil)
	{
		img.uploadGallery = uploadGalleryOrNil;
	}
	
	[self addAsset:img];
	FLReleaseWithNil(img);
}

- (void) addAssetsFromAssetsBrowser:(NSArray*) assets 
                      uploadGallery:(ZFUploadGallery*) uploadGalleryOrNil
{
	NSMutableArray* newAssets = [NSMutableArray arrayWithCapacity:assets.count];
	for(id<FLImageAsset> asset in assets)
	{
		ZFQueuedPhoto* newPhoto = [[ZFQueuedPhoto alloc] initWithImageAsset:asset
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

- (void) changeUploadGalleriesTo:(ZFUploadGallery*) gallery 
                  forMissingOnly:(BOOL) forMissingOnly
{
	FLAssertIsNotNil(gallery);

	FLAssertIsNotNil(self.database);

	NSMutableArray* saveList = [NSMutableArray array]; 
	for(ZFQueuedPhoto* asset in self)
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
	for(ZFQueuedPhoto* asset in self)
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
    ZFUploadGallery* defaultUploadGallery = nil; 
    
	FLAssertIsNotNil(self.database);

	NSMutableArray* saveList = nil; 
	for(ZFQueuedPhoto* asset in self)
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



- (void) _updateAsset:(ZFQueuedPhoto*) photo
           fileNumber:(NSUInteger) fileNumber
{
	FLAssertIsNotNil(self.database);

	ZFUploadGallery* gallery = [self.delegate defaultUploadGallery];
	ZFAccessDescriptor* accessDesc = [self.delegate defaultAccessDescriptor];

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
		
	for(ZFQueuedPhoto* photo in assets) {
		[self _updateAsset:photo fileNumber:++fileCount];
	}
	
	[super batchAddAssets:assets];
}

- (void) addAsset:(ZFQueuedPhoto*) photo {
	[self _updateAsset:photo fileNumber:self.totalAssetsAdded + 1];
	[super addAsset:photo];
}


- (void) _postChangeNotification
{
#if IOS
    [UIApplication sharedApplication].applicationIconBadgeNumber = self.count;
#endif
    [[NSNotificationCenter defaultCenter] postNotification:
        [NSNotification notificationWithName:ZFUploadQueueDidChangeNotification object:nil]];
}

- (void) didChangeAssetQueue
{
    [super didChangeAssetQueue];
    [self performSelectorOnMainThread:@selector(_postChangeNotification) withObject:nil waitUntilDone:NO];
}

@end




#endif
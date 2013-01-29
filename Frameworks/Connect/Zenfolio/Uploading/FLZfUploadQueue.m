//
//  FLZfUploadQueue.m
//  myZenfolio
//
//  Created by Mike Fullerton on 6/13/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLZfUploadQueue.h"
#import "FLZfPreferences.h"
#import "FLZfUtils.h"
#import "NSString+Guid.h"
#import "FLZfUploadablePhoto.h"
#import "ISO8601DateFormatter.h"

#import "FLJpegFileImageAsset.h"
#if IOS
#import "FLAssetsLibraryImageAsset.h"
#endif

#import "FLHtmlStringBuilder.h"
#import "FLZfStorageService.h"
#import "FLZfPrefsService.h"

#if 0
#define TRACE DEBUG
#endif

NSString* const FLZfUploadQueueDidChangeNotification = @"FLZfUploadQueueDidChangeNotification";

@implementation FLZfUploadQueue

@synthesize context = _context;

- (void) didMoveToContext:(id) context {
    _context = context;
}

- (id) init {
	if((self = [super initWithQueueUID:[NSString zeroGuidString]])) {
    }
	
	return self;
}

+ (id) uploadQueue {
    return FLAutorelease([[[self class] alloc] init]);
}

- (Class) queueClass {
	return [FLZfQueuedPhoto class];
}

- (void) didMoveToServiceManagerContext:(FLServiceManager *) context {
    _context = context;
}

- (void) addImageAsset:(id<FLImageAsset>) photo 
             assetType:(FLAssetType) assetType
         uploadGallery:(FLZfUploadGallery*) uploadGalleryOrNil
{
	FLZfQueuedPhoto* img = [[FLZfQueuedPhoto alloc] initWithImageAsset:photo assetType:assetType];
	if(uploadGalleryOrNil)
	{
		img.uploadGallery = uploadGalleryOrNil;
	}
	
	[self addAsset:img];
	FLReleaseWithNil(img);
}

- (void) addAssetsFromAssetsBrowser:(NSArray*) assets 
                      uploadGallery:(FLZfUploadGallery*) uploadGalleryOrNil
{
	NSMutableArray* newAssets = [NSMutableArray arrayWithCapacity:assets.count];
	for(id<FLImageAsset> asset in assets)
	{
		FLZfQueuedPhoto* newPhoto = [[FLZfQueuedPhoto alloc] initWithImageAsset:asset
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

- (void) changeUploadGalleriesTo:(FLZfUploadGallery*) gallery 
                  forMissingOnly:(BOOL) forMissingOnly
{
	FLAssertIsNotNil_(gallery);

	FLAssertIsNotNil_(self.database);

	NSMutableArray* saveList = [NSMutableArray array]; 
	for(FLZfQueuedPhoto* asset in self)
	{
		if(!forMissingOnly || !asset.hasUploadGallery)
		{
			asset.uploadGallery = gallery;
			
			[saveList addObject:asset];
		}
	}

	[self.database batchSaveObjects:saveList];
}

- (BOOL) photosNeedUploadGallery
{
	for(FLZfQueuedPhoto* asset in self)
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
    FLZfUploadGallery* defaultUploadGallery = nil; 
    
	FLAssertIsNotNil_(self.database);

	NSMutableArray* saveList = nil; 
	for(FLZfQueuedPhoto* asset in self)
	{
		if(!asset.hasUploadGallery)
		{
            if(!defaultUploadGallery)
            {
                defaultUploadGallery = [[self.context userStorageService] defaultUploadGallery];
                
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
        [self.database batchSaveObjects:saveList];
    }
}



- (void) _updateAsset:(FLZfQueuedPhoto*) photo
                prefs:(FLZfPreferences*) prefs
              gallery:(FLZfUploadGallery*) gallery
           accessDesc:(FLZfAccessDescriptor*) accessDesc 
           fileNumber:(NSUInteger) fileNumber
{
	FLAssertIsNotNil_(self.database);

	photo.scaledUploadSize = prefs.defaultUploadSize;
	if(photo.assetTypeValue == FLAssetTypeImageFromCamera)
	{
		photo.saveToDeviceBeforeUpload = prefs.saveImagesToPhoneGalleryOnUpload;
	}
	photo.accessDescriptor = accessDesc;
	
	if(!photo.hasUploadGallery)
	{
		photo.uploadGallery = gallery;
	}

	if(FLStringIsEmpty(photo.assetFileName))
	{
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
	FLAssertIsNotNil_(self.database);

	FLZfPreferences* prefs = [[self.context prefsService] loadPreferences];
	FLZfUploadGallery* gallery = [[self.context userStorageService] defaultUploadGallery];
	FLZfAccessDescriptor* accessDesc = [[self.context userStorageService] defaultAccessDescriptor];
	
	NSUInteger fileCount = self.totalAssetsAdded;
		
	for(FLZfQueuedPhoto* photo in assets)
	{
		[self _updateAsset:photo prefs:prefs gallery:gallery accessDesc:accessDesc fileNumber:++fileCount];
	}
	
	[super batchAddAssets:assets];
}

- (void) addAsset:(FLZfQueuedPhoto*) photo {
	FLZfPreferences* prefs = [[self.context prefsService] loadPreferences];
	FLZfUploadGallery* gallery = [[self.context userStorageService] defaultUploadGallery];
	FLZfAccessDescriptor* accessDesc = [[self.context userStorageService] defaultAccessDescriptor];

	[self _updateAsset:photo prefs:prefs gallery:gallery accessDesc:accessDesc fileNumber:self.totalAssetsAdded + 1];
	[super addAsset:photo];
}


- (void) _postChangeNotification
{
#if IOS
    [UIApplication sharedApplication].applicationIconBadgeNumber = self.count;
#endif
    [[NSNotificationCenter defaultCenter] postNotification:
        [NSNotification notificationWithName:FLZfUploadQueueDidChangeNotification object:nil]];
}

- (void) didChangeAssetQueue
{
    [super didChangeAssetQueue];
    [self performSelectorOnMainThread:@selector(_postChangeNotification) withObject:nil waitUntilDone:NO];
}

@end





// [Generated]
//
// FLQueuedAsset.h
// Project: FishLamp Mobile
// Schema: AssetQueueObjects
//
// Copywrite (C) 2012 GreenTongue Software, LLC. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
// [/Generated]


#import "FLQueuedAsset.h"
#import "FLImageAsset.h"

typedef enum {
    FLAssetTypeNone = 0,

	FLAssetTypeImage = (1 << 1),
	FLAssetTypeVideo = (1 << 2),
	
	FLAssetTypeFromAssetsLibrary = (1 << 3),
	FLAssetTypeFromApp = (1 << 4),
	FLAssetTypeFromCamera = (1 << 5),
	
	FLAssetTypeAutoAdded = (1 << 6),

	FLAssetTypeImageFromApp = FLAssetTypeImage | FLAssetTypeFromApp,
	FLAssetTypeImageFromAssetsLibrary = FLAssetTypeImage | FLAssetTypeFromAssetsLibrary,
	FLAssetTypeImageFromCamera = FLAssetTypeImage | FLAssetTypeFromApp | FLAssetTypeFromCamera,

	FLAssetTypeVideoFromAssetsLibrary = FLAssetTypeVideo | FLAssetTypeFromAssetsLibrary,
	FLAssetTypeVideoFromCamera = FLAssetTypeVideo | FLAssetTypeFromApp,
} FLAssetType;

@interface FLQueuedAsset (MyCode)

@property (readwrite, retain, nonatomic) id<FLImageAsset> imageAsset;
@property (readonly, strong, nonatomic) NSString* displayName;

- (id) initWithImageAsset:(id<FLImageAsset>) photo
                assetType:(FLAssetType) assetType;
                
- (id) initWithAssetUID:(NSString*) assetUID;

+ (id) queuedAsset:(NSString*) assetUID;

- (void) createAssetIfNeeded;
@end

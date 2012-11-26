//
//	FLAssetsLibraryImageAsset.h
//	FishLamp
//
//	Created by Mike Fullerton on 7/22/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLAsset.h"
#import "FLImageAsset.h"
#import "FLAssetsLibraryImage.h"

@interface FLAssetsLibraryImageAsset : FLAsset<FLImageAsset> {
@private
	FLAssetsLibraryImage* _originalImage;
	FLAssetsLibraryImage* _fullScreenImage;
	FLAssetsLibraryImage* _thumnailImage;
}

- (id) initWithQueuedAsset:(FLQueuedAsset*) asset;

- (id) initWithAssetURL:(NSURL*) url;

- (id) initWithALAsset:(ALAsset*) asset;

@end

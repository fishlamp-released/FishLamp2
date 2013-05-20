//
//	GtAssetsLibraryImageAsset.h
//	FishLamp
//
//	Created by Mike Fullerton on 7/22/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtAsset.h"
#import "GtImageAsset.h"
#import "GtAssetsLibraryImage.h"

@interface GtAssetsLibraryImageAsset : GtAsset<GtImageAsset> {
@private
	GtAssetsLibraryImage* m_originalImage;
	GtAssetsLibraryImage* m_fullScreenImage;
	GtAssetsLibraryImage* m_thumnailImage;
}

- (id) initWithAssetURL:(NSURL*) url;

- (id) initWithALAsset:(ALAsset*) asset;

@end

//
//  FLAssetsLibraryGroupBrowser.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/12/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLAssetsLibraryBrowserBase.h"
#import "FLThumbnailWithTitleWidget.h"

@interface FLAssetsLibraryGroupBrowser : FLAssetsLibraryBrowserBase {
}

+ (FLAssetsLibraryGroupBrowser*) assetsLibraryGroupBrowser:(FLAssetQueue*) queue;

@end

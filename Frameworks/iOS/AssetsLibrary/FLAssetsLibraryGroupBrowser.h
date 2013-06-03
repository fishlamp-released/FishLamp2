//
//  FLAssetsLibraryGroupBrowser.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/12/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLAssetsLibraryBrowserBase.h"
#import "FLThumbnailWithTitleWidget.h"

@interface FLAssetsLibraryGroupBrowser : FLAssetsLibraryBrowserBase {
}

+ (FLAssetsLibraryGroupBrowser*) assetsLibraryGroupBrowser:(FLAssetQueue*) queue;

@end

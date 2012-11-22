//
//  FLAssetsLibraryModule.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/12/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLAssetsLibraryModule.h"
#import "FLAssetsLibraryImageAsset.h"
#import "FLBackgroundTaskModuleCore.h"
#import "FLAssetFactory.h"

@implementation FLAssetsLibraryModule

- (void) initializeModule {
    [[FLAssetFactory instance] addAssetClass:[FLAssetsLibraryImageAsset class]];

    [FLBackgroundTaskModuleCore initializeModule];
}

@end

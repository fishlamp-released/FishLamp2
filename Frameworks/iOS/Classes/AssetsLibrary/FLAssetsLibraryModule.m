//
//  FLAssetsLibraryModule.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/12/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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

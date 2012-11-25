//
//  FLAssetFactory.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/12/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLQueuedAsset.h"

@interface FLAssetFactory : NSObject {
@private
    NSMutableDictionary* _factoryBlocks;
}
FLSingletonProperty(FLAssetFactory);

- (void) addAssetClass:(Class) aAssetClass;

- (id) createAssetForQueuedAsset:(FLQueuedAsset*) queuedAsset;


@end

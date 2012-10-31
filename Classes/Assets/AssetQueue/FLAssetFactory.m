//
//  FLAssetFactory.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/12/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLAssetFactory.h"
#import "FLAsset.h"

#import "FLJpegFileImageAsset.h"

@implementation FLAssetFactory

FLSynthesizeSingleton(FLAssetFactory);

- (id) init {
    self = [super init];
    if(self) {
        _factoryBlocks = [[NSMutableDictionary alloc] init];
        
        [self addAssetClass:[FLJpegFileImageAsset class]];
    }
    return self;
}

#if FL_MRC
- (void) dealloc {
    mrc_release_(_factoryBlocks);
    mrc_super_dealloc_();
}
#endif

- (void) addAssetClass:(Class) aAssetClass {
 
    [_factoryBlocks setObject:aAssetClass forKey:[aAssetClass assetURLScheme]];
}


- (id) createAssetForQueuedAsset:(FLQueuedAsset*) queuedAsset {
    
    NSString* urlString = queuedAsset.assetURL;
    NSRange prefixLocation = [urlString rangeOfString:@":"];
    if(prefixLocation.location > 0) {
        Class aClass = [_factoryBlocks objectForKey:[urlString substringToIndex:prefixLocation.location]];
        if(aClass) {
            return autorelease_([[aClass alloc] initWithQueuedAsset:queuedAsset]);
        }
    }

    return nil;
}

@end



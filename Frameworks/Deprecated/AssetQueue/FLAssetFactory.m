//
//  FLAssetFactory.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/12/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

//#import "FLAssetFactory.h"
//#import "FLAsset.h"
//
//#import "FLJpegFileImageAsset.h"
//
//@implementation FLAssetFactory
//
//FLSynthesizeSingleton(FLAssetFactory);
//
//- (id) init {
//    self = [super init];
//    if(self) {
//        _factoryBlocks = [[NSMutableDictionary alloc] init];
//        
//        [self addAssetClass:[FLJpegFileImageAsset class]];
//    }
//    return self;
//}
//
//#if FL_MRC
//- (void) dealloc {
//    FLRelease(_factoryBlocks);
//    FLSuperDealloc();
//}
//#endif
//
//- (void) addAssetClass:(Class) aAssetClass {
// 
//    [_factoryBlocks setObject:aAssetClass forKey:[aAssetClass assetURLScheme]];
//}
//
//
//- (id) createAssetForQueuedAsset:(FLQueuedAsset*) queuedAsset {
//
//FIXME("Assets")
//    
////    NSString* urlString = queuedAsset.assetURL;
////    NSRange prefixLocation = [urlString rangeOfString:@":"];
////    if(prefixLocation.location > 0) {
////        Class aClass = [_factoryBlocks objectForKey:[urlString substringToIndex:prefixLocation.location]];
////        if(aClass) {
////            return FLAutorelease([[aClass alloc] initWithQueuedAsset:queuedAsset]);
////        }
////    }
//
//    return nil;
//}
//
//@end
//
//

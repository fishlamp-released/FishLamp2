//
//  FLImageCacheService.m
//  Downloader
//
//  Created by Mike Fullerton on 11/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLImageCacheService.h"

service_register_(imageCacheService, FLImageCacheService, @"com.fishlamp.service.image-cache");

@implementation FLImageCacheService

- (FLDatabase*) cacheDatabase {
    return [[self.context storageService] cacheDatabase];
}

- (FLImageFolder*) imageCacheFolder {
    return [[self.context storageService] imageCacheFolder];
}

- (void) saveImage:(FLImage*) image {
    [self.cacheDatabase saveObject:image.imageProperties];
    [self.imageCacheFolder writeImage:image];
}

- (void) deleteImage:(FLImage*) image {
    [self.imageCacheFolder deleteImage:image];
    [self.cacheDatabase deleteObject:image];
}

- (FLImage*) loadImageForURL:(NSURL*) url {
    FLImageProperties* input = [FLImageProperties imagePropertiesWithImageURL:url];
    FLImageProperties* props = [self.cacheDatabase loadObject:input];
    if(props) {
        FLImage* image = [FLImage imageWithImageProperties:props];
        
// TODO: add storage strategy!!        
        
        return image;
    }
    
    return nil;
}

@end

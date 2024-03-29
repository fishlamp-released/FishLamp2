//
//  FLGalleryDataSource.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/2/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLAction.h"
#import "FLGalleryObject.h"

typedef enum {
    FLGalleryImageSizeHintNone,
    FLGalleryImageSizeHintThumbnail,
    FLGalleryImageSizeHintFullScreen,
    FLGalleryImageSizeHintFullScreenZoomed
} FLGalleryImageSizeHint;

#define FLGalleryDataSourceErrorDomain @"FLGalleryDataSourceErrorDomain"
typedef enum {
    FLGalleryDataSourceErrorNotLoaded = 1,
    FLGalleryDataSourceErrorNotFound
} FLGalleryDataSourceErrorNum;

@protocol FLGalleryDataModel <NSObject>

@property (readwrite, assign, nonatomic) NSUInteger pageSize;

- (FLAction*) galleryLoaderWithGalleryID:(id) galleryID;

- (FLAction*) childrenLoaderForGallery:(id) galleryContainer
                         startingIndex:(NSUInteger) startingIndex;
    
- (FLAction*) imageLoaderForGalleryObject:(id) galleryObject
                               sizeInView:(CGSize) imageSize
                                 sizeHint:(FLGalleryImageSizeHint) sizeHint;
    

@end

@interface FLAction (FLGalleryDataModel)
- (id<FLGalleryObject>) loadGalleryResult;
- (NSArray*) loadChildrenResult;
- (UIImage*) loadImageResult;
@end




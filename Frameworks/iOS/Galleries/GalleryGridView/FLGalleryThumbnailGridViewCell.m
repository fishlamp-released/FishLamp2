//
//  FLGalleryThumbnailGridViewCell.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/3/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLGalleryThumbnailGridViewCell.h"
#import "FLGalleryThumbnailGridViewCellView.h"

@implementation FLGalleryThumbnailGridViewCell

+ (FLGalleryThumbnailGridViewCell*) galleryThumbnailGridViewCell:(id) dataRef {
    return FLAutorelease([[FLGalleryThumbnailGridViewCell alloc] initWithDataRef:dataRef]);
}

- (UIView*) createPrimaryView {
    return FLAutorelease([[FLGalleryThumbnailGridViewCellView alloc] initWithFrame:CGRectZero]);
}

@end

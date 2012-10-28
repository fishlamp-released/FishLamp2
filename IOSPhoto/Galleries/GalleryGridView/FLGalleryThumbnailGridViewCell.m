//
//  FLGalleryThumbnailGridViewCell.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/3/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLGalleryThumbnailGridViewCell.h"
#import "FLGalleryThumbnailGridViewCellView.h"

@implementation FLGalleryThumbnailGridViewCell

+ (FLGalleryThumbnailGridViewCell*) galleryThumbnailGridViewCell:(id) dataRef {
    return FLReturnAutoreleased([[FLGalleryThumbnailGridViewCell alloc] initWithDataRef:dataRef]);
}

- (UIView*) createPrimaryView {
    return FLReturnAutoreleased([[FLGalleryThumbnailGridViewCellView alloc] initWithFrame:CGRectZero]);
}

@end

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
    return autorelease_([[FLGalleryThumbnailGridViewCell alloc] initWithDataRef:dataRef]);
}

- (UIView*) createPrimaryView {
    return autorelease_([[FLGalleryThumbnailGridViewCellView alloc] initWithFrame:CGRectZero]);
}

@end

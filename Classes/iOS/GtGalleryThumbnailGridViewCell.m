//
//  GtGalleryThumbnailGridViewCell.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/3/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtGalleryThumbnailGridViewCell.h"
#import "GtGalleryThumbnailGridViewCellView.h"

@implementation GtGalleryThumbnailGridViewCell

+ (GtGalleryThumbnailGridViewCell*) galleryThumbnailGridViewCell:(id) gridViewObject
{
    return GtReturnAutoreleased([[GtGalleryThumbnailGridViewCell alloc] initWithGridViewObject:gridViewObject]);
}

- (UIView*) createPrimaryView
{
    return GtReturnAutoreleased([[GtGalleryThumbnailGridViewCellView alloc] initWithFrame:CGRectZero]);
}

@end

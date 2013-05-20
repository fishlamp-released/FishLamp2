//
//  GtBigThumbnailGallery.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/3/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtBigThumbnailGallery.h"
#import "GtPhotoThumbnailGridViewCell.h"
@implementation GtBigThumbnailViewVerticalLayout
 
GtSynthesizeSingleton(GtBigThumbnailViewVerticalLayout)

- (id) init
{
    if((self = [super init]))
    {
        self.delegate = self;
    }
    
    return self;
}

- (CGSize) cellViewLayoutGetCellSize:(GtCellViewLayout*) layout
{
    return DeviceIsPad() ? 
        CGSizeMake(256.0, 256.0) :
        CGSizeMake(106.0f, 106.0f);
}

@end
//
//  FLGalleryThumbnailGridViewCellView.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/3/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLGalleryThumbnailGridViewCellView.h"

@implementation FLGalleryThumbnailGridViewCellView

- (id) initWithFrame:(FLRect) frame
{
    if((self = [super initWithFrame:frame]))
    {
        self.thumbnailWidget.showStack = YES;
    }
    
    return self;
}

@end

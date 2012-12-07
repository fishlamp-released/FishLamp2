//
//  FLBigThumbnailGallery.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/3/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLBigThumbnailViewVerticalLayout.h"
#import "FLPhotoThumbnailGridViewCell.h"

@implementation FLBigThumbnailViewVerticalLayout
 
FLSynthesizeSingleton(FLBigThumbnailViewVerticalLayout)

- (id) init
{
    if((self = [super init]))
    {
        self.onWillArrange = ^(id arrangement, CGRect bounds) {
            if(bounds.size.width > bounds.size.height) {
                self.columnCount = 4;
            }
            else {
                self.columnCount = 6;
            }
        };
    }
    
    return self;
}

//- (FLSize) cellViewLayoutGetCellSize:(FLCellArrangement*) layout inBounds:(CGRect) bounds
//{
//    if(DeviceIsPad())
//    {
//        return (bounds.size.width > bounds.size.height) ? 
//            FLSizeMake(170.0, 170.0) :
//            FLSizeMake(192.0, 192.0);
//    
//    }    
//    return FLSizeMake(106.0f, 106.0f);
//}

@end
//
//  FLBigThumbnailGallery.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/3/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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

//- (CGSize) cellViewLayoutGetCellSize:(FLCellArrangement*) layout inBounds:(CGRect) bounds
//{
//    if(DeviceIsPad())
//    {
//        return (bounds.size.width > bounds.size.height) ? 
//            CGSizeMake(170.0, 170.0) :
//            CGSizeMake(192.0, 192.0);
//    
//    }    
//    return CGSizeMake(106.0f, 106.0f);
//}

@end
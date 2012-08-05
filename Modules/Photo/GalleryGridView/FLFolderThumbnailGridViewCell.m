//
//  FLFolderThumbnailGridViewCell.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/3/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLFolderThumbnailGridViewCell.h"
#import "FLFolderThumbnailGridViewCellView.h"

@implementation FLFolderThumbnailGridViewCell

+ (FLFolderThumbnailGridViewCell*) folderThumbnailGridViewCell:(id) gridViewObject
{
    return FLReturnAutoreleased([[FLFolderThumbnailGridViewCell alloc] initWithGridViewObject:gridViewObject]);
}

- (UIView*) createPrimaryView
{
    return FLReturnAutoreleased([[FLFolderThumbnailGridViewCellView alloc] initWithFrame:CGRectZero]);
}
@end

//
//  GtFolderThumbnailGridViewCell.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/3/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFolderThumbnailGridViewCell.h"
#import "GtFolderThumbnailGridViewCellView.h"

@implementation GtFolderThumbnailGridViewCell

+ (GtFolderThumbnailGridViewCell*) folderThumbnailGridViewCell:(id) gridViewObject
{
    return GtReturnAutoreleased([[GtFolderThumbnailGridViewCell alloc] initWithGridViewObject:gridViewObject]);
}

- (UIView*) createPrimaryView
{
    return GtReturnAutoreleased([[GtFolderThumbnailGridViewCellView alloc] initWithFrame:CGRectZero]);
}
@end

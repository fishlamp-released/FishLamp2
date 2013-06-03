//
//  FLFolderThumbnailGridViewCell.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/3/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLFolderThumbnailGridViewCell.h"
#import "FLFolderThumbnailGridViewCellView.h"

@implementation FLFolderThumbnailGridViewCell

+ (FLFolderThumbnailGridViewCell*) folderThumbnailGridViewCell:(id) dataRef {
    return FLAutorelease([[FLFolderThumbnailGridViewCell alloc] initWithDataRef:dataRef]);
}

- (UIView*) createPrimaryView {
    return FLAutorelease([[FLFolderThumbnailGridViewCellView alloc] initWithFrame:CGRectZero]);
}
@end

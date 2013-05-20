//
//  GtFolderThumbnailGridViewCellView.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/3/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFolderThumbnailGridViewCellView.h"

@implementation GtFolderThumbnailGridViewCellView

- (id) initWithFrame:(CGRect) frame
{
    if((self = [super initWithFrame:frame]))
    {
        self.thumbnailWidget.showStack = YES;
    }
    
    return self;
}

@end

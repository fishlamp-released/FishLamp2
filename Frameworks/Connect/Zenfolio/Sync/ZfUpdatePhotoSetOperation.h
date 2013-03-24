//
//  ZFUpdatePhotoSetOperation.h
//  ZenLib
//
//  Created by Mike Fullerton on 10/13/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLOperation.h"
#import "ZFImageDisplaySize.h"

@interface ZFUpdatePhotoSetOperation : FLOperation {
@private
    NSNumber* _photoSetID;
    ZFImageDisplaySize* _displaySize;
    BOOL _syncPhotos;
    BOOL _syncLargeImages;
}

- (id) initWithPhotoSetID:(NSNumber*) photoSetID
               syncPhotos:(BOOL) syncPhotos
          syncLargeImages:(BOOL) syncLargeImages
              displaySize:(ZFImageDisplaySize*) displaySize;

@end

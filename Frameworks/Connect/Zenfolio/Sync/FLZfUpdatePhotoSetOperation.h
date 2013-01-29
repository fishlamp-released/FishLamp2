//
//  FLZfUpdatePhotoSetOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/13/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLOperation.h"
#import "FLZfImageDisplaySize.h"

@interface FLZfUpdatePhotoSetOperation : FLOperation {
@private
    NSNumber* _photoSetID;
    FLZfImageDisplaySize* _displaySize;
    BOOL _syncPhotos;
    BOOL _syncLargeImages;
}

- (id) initWithPhotoSetID:(NSNumber*) photoSetID
    syncPhotos:(BOOL) syncPhotos
    syncLargeImages:(BOOL) syncLargeImages
    displaySize:(FLZfImageDisplaySize*) displaySize;

@end

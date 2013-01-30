//
//  FLZenfolioUpdatePhotoSetOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/13/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLOperation.h"
#import "FLZenfolioImageDisplaySize.h"

@interface FLZenfolioUpdatePhotoSetOperation : FLOperation {
@private
    NSNumber* _photoSetID;
    FLZenfolioImageDisplaySize* _displaySize;
    BOOL _syncPhotos;
    BOOL _syncLargeImages;
}

- (id) initWithPhotoSetID:(NSNumber*) photoSetID
    syncPhotos:(BOOL) syncPhotos
    syncLargeImages:(BOOL) syncLargeImages
    displaySize:(FLZenfolioImageDisplaySize*) displaySize;

@end

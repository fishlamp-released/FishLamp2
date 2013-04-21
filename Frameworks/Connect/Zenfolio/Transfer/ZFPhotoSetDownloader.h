//
//  ZFPhotoSetDownloader.h
//  FishLampConnect
//
//  Created by Mike Fullerton on 4/20/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAsyncOperation.h"

@interface ZFPhotoSetDownloader : FLAsyncOperation {
@private
    NSNumber* _photoSetID;
    BOOL _withPhotos;
}

+ (id) downloadPhotoSet:(NSNumber*) photoSetID withPhotos:(BOOL) withPhotos;

@end

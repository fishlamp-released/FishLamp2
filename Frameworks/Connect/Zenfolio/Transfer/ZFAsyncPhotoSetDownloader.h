//
//  ZFAsyncPhotoSetDownloader.h
//  FishLampConnect
//
//  Created by Mike Fullerton on 4/20/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAsyncOperation.h"

@interface ZFAsyncPhotoSetDownloader : FLAsyncOperation {
@private
    NSNumber* _photoSetID;
    
}

+ (id) downloadPhotoSet:(NSNumber*) photoSetID;

@end

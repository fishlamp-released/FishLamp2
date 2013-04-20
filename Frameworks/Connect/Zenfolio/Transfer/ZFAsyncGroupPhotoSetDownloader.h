//
//  ZFAsyncGroupPhotoSetDownloader.h
//  FishLampConnect
//
//  Created by Mike Fullerton on 4/20/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAsyncOperation.h"

@interface ZFAsyncGroupPhotoSetDownloader : FLAsyncOperation {
@private
    ZFGroup* _group;
}

+ (id) asyncGroupPhotoSetDownloader:(ZFGroup*) group;

@end


@protocol ZFAsyncGroupPhotoSetDownloaderObserver <NSObject>
@optional

- (void) asyncGroupPhotoSetDownloader:(ZFAsyncGroupPhotoSetDownloader*) operation 
                  didDownloadPhotoSet:(ZFPhotoSet*) photoSet; 
@end
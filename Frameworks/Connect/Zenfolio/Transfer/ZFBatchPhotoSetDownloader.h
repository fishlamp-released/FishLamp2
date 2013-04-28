//
//  ZFBatchPhotoSetDownloader.h
//  FishLampConnect
//
//  Created by Mike Fullerton on 4/20/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAsyncOperationQueue.h"

@interface ZFBatchPhotoSetDownloader : FLAsyncOperationQueue {
@private
    ZFGroup* _group;
    BOOL _withPhotos;
}

+ (id) batchPhotoSetDownloaderForGroup:(ZFGroup*) group withPhotos:(BOOL) withPhotos;
+ (id) batchPhotoSetDownloader:(NSArray*) arrayOfPhotoSetIDs withPhotos:(BOOL) withPhotos;

@end


@protocol ZFBatchPhotoSetDownloaderDelegate <FLOperationDelegate>
@optional
- (void) batchPhotoSetDownloader:(ZFBatchPhotoSetDownloader*) downloader 
            willDownloadPhotoSet:(ZFPhotoSet*) result; 

- (void) batchPhotoSetDownloader:(ZFBatchPhotoSetDownloader*) downloader 
   didDownloadPhotoSetWithResult:(FLPromisedResult) result; 
@end


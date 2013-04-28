//
//  ZFPhotoDownloaderQueue.h
//  FishLampConnect
//
//  Created by Mike Fullerton on 4/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAsyncOperationQueue.h"
#import "ZFDownloadSpec.h"
#import "ZFBatchDownloadSpec.h"
#import "ZFPhotoDownloader.h"

@interface ZFPhotoDownloaderQueue : FLAsyncOperationQueue {
@private
}

- (id) initWithArrayOfDownloadSpecs:(NSArray*) arrayOfDownloadSpecs;
+ (id) photoDownloaderQueue:(NSArray*) arrayOfDownloadSpecs;

@end

@protocol ZFPhotoDownloadQueueDelegate <FLAsyncOperationQueueDelegate>
- (void) photoDownloadQueue:(ZFPhotoDownloaderQueue*) downloadQueue 
photoDownloaderDidDownloadPhoto:(ZFPhotoDownloader*) downloader;
@end
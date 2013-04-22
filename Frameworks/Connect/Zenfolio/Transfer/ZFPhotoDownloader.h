//
//  ZFPhotoDownloader.h
//  FishLampConnect
//
//  Created by Mike Fullerton on 4/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAsyncOperation.h"
#import "ZFDownloadSpec.h"

@interface ZFPhotoDownloader : FLAsyncOperation {
@private
    ZFDownloadSpec* _downloadSpec;
    unsigned long long _downloadedByteCount;
    NSTimeInterval _lastTime;
    NSTimeInterval _startTime;
}

@property (readonly, strong, nonatomic) ZFDownloadSpec* downloadSpec;

@property (readonly, assign) unsigned long long downloadedByteCount;
@property (readonly, assign) NSTimeInterval startTime;
@property (readonly, assign) NSTimeInterval lastTime;
@property (readonly, assign) NSTimeInterval elapsedTime;

+ (id) photoDownloader:(ZFDownloadSpec*) downloadSpec;

@end

@protocol FLPhotoDownloaderDelegate <FLOperationDelegate>
- (void) photoDownloaderDidSkipPhoto:(ZFPhotoDownloader*) downloader;
- (void) photoDownloaderDidDownloadPhoto:(ZFPhotoDownloader*) downloader;
- (void) photoDownloader:(ZFPhotoDownloader*) downloader didReadBytes:(NSNumber*) amount;
@end
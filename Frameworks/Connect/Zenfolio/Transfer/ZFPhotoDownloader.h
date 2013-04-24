//
//  ZFPhotoDownloader.h
//  FishLampConnect
//
//  Created by Mike Fullerton on 4/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAsyncOperation.h"
#import "ZFDownloadSpec.h"
#import "FLHttpRequest.h"

@interface ZFPhotoDownloader : FLHttpRequest {
@private
    ZFDownloadSpec* _downloadSpec;
}
@property (readonly, strong, nonatomic) ZFDownloadSpec* downloadSpec;
+ (id) photoDownloader:(ZFDownloadSpec*) downloadSpec;
@end

@protocol FLPhotoDownloaderDelegate <FLHttpRequestDelegate>
@optional
- (void) photoDownloaderDidSkipPhoto:(ZFPhotoDownloader*) downloader;
- (void) photoDownloaderDidDownloadPhoto:(ZFPhotoDownloader*) downloader;
@end
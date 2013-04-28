//
//  ZFPhotoDownloader.h
//  FishLampConnect
//
//  Created by Mike Fullerton on 4/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAsyncOperation.h"
#import "ZFDownloadSpec.h"
#import "FLHttpOperation.h"

@interface ZFPhotoDownloader : FLAsyncOperation {
@private
    ZFDownloadSpec* _downloadSpec;
}
+ (id) photoDownloader:(ZFDownloadSpec*) downloadSpec;
@end

@protocol ZFPhotoDownloaderDelegate <NSObject>
- (void) photoDownloader:(ZFPhotoDownloader*) downloader 
            didReadBytes:(FLHttpRequestByteCount*) amount 
                forPhoto:(ZFDownloadSpec*) downloadSpec;
@end
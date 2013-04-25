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

typedef enum {
    ZFPhotoDownloaderHintPhotoWasDownloaded,
    ZFPhotoDownloaderHintPhotoWasSkipped
} ZFPhotoDownloaderHint;

@interface ZFPhotoDownloader : FLAsyncOperation {
@private
    ZFDownloadSpec* _downloadSpec;
}
@property (readonly, strong, nonatomic) ZFDownloadSpec* downloadSpec;
+ (id) photoDownloader:(ZFDownloadSpec*) downloadSpec;
@end


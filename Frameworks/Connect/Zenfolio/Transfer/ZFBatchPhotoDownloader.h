//
//  ZFBatchPhotoDownloader.h
//  FishLampConnect
//
//  Created by Mike Fullerton on 4/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLAsyncOperation.h"
#import "ZFBatchDownloadSpec.h"
#import "ZFDownloadQueue.h"
#import "FLDispatchQueue.h"

@interface ZFBatchPhotoDownloader : FLAsyncOperation {
@private
    ZFBatchDownloadSpec* _downloadSpec;
    NSArray* _downloadQueue;
}

+ (id) batchPhotoDownloadOperation:(ZFBatchDownloadSpec*) spec;

@end

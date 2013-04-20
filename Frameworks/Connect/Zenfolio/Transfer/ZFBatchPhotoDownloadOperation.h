//
//  ZFBatchPhotoDownloadOperation.h
//  FishLampConnect
//
//  Created by Mike Fullerton on 4/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLOperation.h"
#import "ZFBatchDownloadSpec.h"
#import "ZFDownloadQueue.h"
#import "FLDispatchQueue.h"

@interface ZFBatchPhotoDownloadOperation : FLOperation {
@private
    ZFBatchDownloadSpec* _downloadSpec;
    FLFifoAsyncQueue* _fifoQueue;
    NSMutableArray* _activeQueue;
    FLFinisher* _finisher;
}
@property (readonly, strong) ZFDownloadQueue* downloadQueue;

+ (id) batchPhotoDownloadOperation:(ZFBatchDownloadSpec*) spec;

@end

//
//  FLPrepareDownloadQueueOperation.h
//  FishLampConnect
//
//  Created by Mike Fullerton on 4/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLSynchronousOperation.h"
#import "ZFBatchDownloadSpec.h"
#import "ZFDownloadQueue.h"

@interface FLPrepareDownloadQueueOperation : FLSynchronousOperation {
@private
    ZFBatchDownloadSpec* _downloadSpec;
    ZFGroup* _rootGroup;
    BOOL _downloadImages;
    BOOL _downloadVideos;
}

+ (id) prepareDownloadQueueOperation:(ZFBatchDownloadSpec*) downloadSpec;

@end


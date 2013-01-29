//
//  ZFUploadQueueUserService.h
//  ZenLib
//
//  Created by Mike Fullerton on 11/3/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLService.h"

#import "ZFUploadQueue.h"

@interface ZFUploadQueueUserService : FLService {
@private
    ZFUploadQueue* _uploadQueue;
}

@property (readonly, strong) ZFUploadQueue* uploadQueue;

@end

FLPublishService(uploadService, ZFUploadQueueUserService*)
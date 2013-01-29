//
//  FLZfUploadQueueUserService.h
//  FishLamp
//
//  Created by Mike Fullerton on 11/3/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLService.h"

#import "FLZfUploadQueue.h"

@interface FLZfUploadQueueUserService : FLService {
@private
    FLZfUploadQueue* _uploadQueue;
}

@property (readonly, strong) FLZfUploadQueue* uploadQueue;

@end

FLPublishService(uploadService, FLZfUploadQueueUserService*)
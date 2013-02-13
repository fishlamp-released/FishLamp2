//
//  FLZenfolioUploadQueueUserService.h
//  FishLamp
//
//  Created by Mike Fullerton on 11/3/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLService.h"

#import "FLZenfolioUploadQueue.h"

@interface FLZenfolioUploadQueueUserService : FLService {
@private
    FLZenfolioUploadQueue* _uploadQueue;
}

@property (readonly, strong) FLZenfolioUploadQueue* uploadQueue;

@end


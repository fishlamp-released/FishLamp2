//
//  FLZenfolioUploadQueueUserService.m
//  FishLamp
//
//  Created by Mike Fullerton on 11/3/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZenfolioUploadQueueUserService.h"

@interface FLZenfolioUploadQueueUserService ()
@property (readwrite, strong) FLZenfolioUploadQueue* uploadQueue;
@end

@implementation FLZenfolioUploadQueueUserService

@synthesize uploadQueue = _uploadQueue;

- (void) openService {
}

@end

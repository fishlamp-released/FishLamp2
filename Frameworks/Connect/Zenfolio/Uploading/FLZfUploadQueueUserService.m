//
//  FLZfUploadQueueUserService.m
//  FishLamp
//
//  Created by Mike Fullerton on 11/3/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLZfUploadQueueUserService.h"

@interface FLZfUploadQueueUserService ()
@property (readwrite, strong) FLZfUploadQueue* uploadQueue;
@end

@implementation FLZfUploadQueueUserService

@synthesize uploadQueue = _uploadQueue;

- (void) openService {
}

@end

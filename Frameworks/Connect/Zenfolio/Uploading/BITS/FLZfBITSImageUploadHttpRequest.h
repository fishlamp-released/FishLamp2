//
//  FLZfBITSImageUploadHttpRequest.h
//  Downloader
//
//  Created by Mike Fullerton on 11/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLHttpRequest.h"
#import "FLZfQueuedPhoto.h"

@interface FLZfBITSImageUploadHttpRequest : FLHttpRequest {
@private
    FLZfQueuedPhoto* _queuedPhoto;
}

@property (readwrite, strong) FLZfQueuedPhoto* queuedPhoto;

- (id) initWithQueuedPhoto:(FLZfQueuedPhoto*) photo;

@end

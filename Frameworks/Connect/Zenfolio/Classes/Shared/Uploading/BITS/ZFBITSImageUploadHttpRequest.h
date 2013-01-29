//
//  ZFBITSImageUploadHttpRequest.h
//  Downloader
//
//  Created by Mike Fullerton on 11/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLHttpRequest.h"
#import "ZFQueuedPhoto.h"

@interface ZFBITSImageUploadHttpRequest : FLHttpRequest {
@private
    ZFQueuedPhoto* _queuedPhoto;
}

@property (readwrite, strong) ZFQueuedPhoto* queuedPhoto;

- (id) initWithQueuedPhoto:(ZFQueuedPhoto*) photo;

@end

//
//  FLZenfolioBITSImageUploadHttpRequest.h
//  Downloader
//
//  Created by Mike Fullerton on 11/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLHttpRequest.h"
#import "FLZenfolioQueuedPhoto.h"

@interface FLZenfolioBITSImageUploadHttpRequest : FLHttpRequest {
@private
    FLZenfolioQueuedPhoto* _queuedPhoto;
}

@property (readwrite, strong) FLZenfolioQueuedPhoto* queuedPhoto;

- (id) initWithQueuedPhoto:(FLZenfolioQueuedPhoto*) photo;

@end

//
//  ZFBITSImageUploadHttpRequest.m
//  Downloader
//
//  Created by Mike Fullerton on 11/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//
#if REFACTOR

#import "ZFBITSImageUploadHttpRequest.h"

@implementation ZFBITSImageUploadHttpRequest

@synthesize queuedPhoto = _queuedPhoto;

#if FL_MRC
- (void) dealloc {
    [_queuedPhoto release];
    [super dealloc];
}
#endif

- (id) initWithQueuedPhoto:(ZFQueuedPhoto*) photo {
    self = [super init];
    if(self) {
        self.queuedPhoto = photo;
    }
    return self;
}

@end
#endif
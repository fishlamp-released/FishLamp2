//
//  ZFPrepareImageForUploadOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/1/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//
#if REFACTOR
#import "FLSynchronousOperation.h"
#import "ZFQueuedPhoto.h"
#import "FLJpegFile.h"

@interface ZFPrepareImageForUploadOperation : FLSynchronousOperation {
@private
	ZFQueuedPhoto* _photo;
    unsigned long long _startSize;
    unsigned long long _finalSize;
}

@property (readonly, assign, nonatomic) unsigned long long startFileSize;
@property (readonly, assign, nonatomic) unsigned long long finalFileSize;

- (id) initWithUploadablePhoto:(ZFQueuedPhoto*) photo;

@end
#endif
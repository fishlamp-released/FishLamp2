//
//  FLZfSinglePhotoBITSUploader.h
//  FishLamp
//
//  Created by Mike Fullerton on 8/31/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLZfSinglePhotoUploader.h"
#import "FLZfBitsUploadProtocolResponse.h"

#define kZfSinglePhotoBITSUploaderExpireTime 1680 // 28 minutes

@interface FLZfSinglePhotoBITSUploader : FLZfSinglePhotoUploader {
@private
    FLZfBitsUploadProtocolResponse* _sessionInfo;
    unsigned long long _chunkStart;
    unsigned long long _fileSize;
    NSTimeInterval _startTime;
    BOOL _closing;
}

@property (readonly, assign, nonatomic) BOOL hasExpired;
@property (readonly, assign, nonatomic) BOOL isBusy;
@property (readonly, assign, nonatomic) BOOL isClosing;

@end

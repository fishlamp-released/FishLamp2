//
//  FLZenfolioSinglePhotoBITSUploader.h
//  FishLamp
//
//  Created by Mike Fullerton on 8/31/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLZenfolioSinglePhotoUploader.h"
#import "FLZenfolioBitsUploadProtocolResponse.h"

#define kZenfolioSinglePhotoBITSUploaderExpireTime 1680 // 28 minutes

@interface FLZenfolioSinglePhotoBITSUploader : FLZenfolioSinglePhotoUploader {
@private
    FLZenfolioBitsUploadProtocolResponse* _sessionInfo;
    unsigned long long _chunkStart;
    unsigned long long _fileSize;
    NSTimeInterval _startTime;
    BOOL _closing;
}

@property (readonly, assign, nonatomic) BOOL hasExpired;
@property (readonly, assign, nonatomic) BOOL isBusy;
@property (readonly, assign, nonatomic) BOOL isClosing;

@end

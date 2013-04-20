//
//  ZFDownloadPhotoOperation.h
//  FishLampConnect
//
//  Created by Mike Fullerton on 4/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLSynchronousOperation.h"
#import "ZFDownloadSpec.h"

@interface ZFDownloadPhotoOperation : FLSynchronousOperation {
@private
    ZFDownloadSpec* _downloadSpec;
    unsigned long long _downloadedByteCount;
    NSTimeInterval _lastTime;
    NSTimeInterval _startTime;
}

@property (readonly, strong, nonatomic) ZFDownloadSpec* downloadSpec;

@property (readonly, assign) unsigned long long downloadedByteCount;
@property (readonly, assign) NSTimeInterval startTime;
@property (readonly, assign) NSTimeInterval lastTime;
@property (readonly, assign) NSTimeInterval elapsedTime;

+ (id) downloadPhotoOperation:(ZFDownloadSpec*) downloadSpec;

@end

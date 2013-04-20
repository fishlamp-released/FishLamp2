//
//  ZFDownloadQueue.h
//  FishLampConnect
//
//  Created by Mike Fullerton on 4/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZFDownloadSpec.h"

@interface ZFBatchQueue : NSObject {
@private
    NSMutableArray* _queue;
}

- (void) addObject:(id) object;

@end

@interface ZFDownloadQueue : ZFBatchQueue {
@private
    NSUInteger _totalPhotoCount;
    NSUInteger _downloadedPhotoCount;
    NSUInteger _totalVideoCount;
    NSUInteger _downloadVideoCount;
    unsigned long long _totalPhotoSize;
    unsigned long long _downloadedPhotoSize;
    unsigned long long _totalVideoSize;
    unsigned long long _downloadedVideoSize;

    NSTimeInterval _elapsedTime;
}

@property (readonly, assign) NSUInteger totalPhotoCount;
@property (readonly, assign) NSUInteger downloadedPhotoCount;
@property (readonly, assign) unsigned long long totalPhotoSize;
@property (readonly, assign) unsigned long long downloadedPhotoSize;

@property (readonly, assign) NSUInteger totalVideoCount;
@property (readonly, assign) NSUInteger downloadedVideoCount;
@property (readonly, assign) unsigned long long totalVideoSize;
@property (readonly, assign) unsigned long long downloadedVideoSize;

@property (readonly, assign) NSTimeInterval elapsedTime;

+ (id) downloadQueue;

- (ZFDownloadSpec*) popDownloadSpec;

@end

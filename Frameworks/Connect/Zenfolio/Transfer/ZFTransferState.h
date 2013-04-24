//
//  ZFTransferState.h
//  FishLampConnect
//
//  Created by Mike Fullerton on 4/11/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FishLampCocoa.h"
#import "FLModelObject.h"

typedef struct {
    NSUInteger videoCount;
    NSUInteger videoTotal;
    NSUInteger photoCount;
    NSUInteger photoTotal;
    NSUInteger photoSetCount;
    NSUInteger photoSetTotal;
    unsigned long long byteTotal;
    unsigned long long byteCount;
    NSTimeInterval startedTime;
    NSTimeInterval transferTime;
    unsigned long long transferredBytes;
    unsigned long long currentPhotoBytes;
} ZFTransferState_t;

@interface ZFTransferState : NSObject<NSCopying> {
@private
    NSUInteger _videoCount;
    NSUInteger _videoTotal;
    NSUInteger _photoCount;
    NSUInteger _photoTotal;
    NSUInteger _photoSetCount;
    NSUInteger _photoSetTotal;
    unsigned long long _byteTotal;
    unsigned long long _byteCount;
    NSTimeInterval _startedTime;
    NSTimeInterval _finishedTime;
    unsigned long long _bytesPerSecondTotal;
    long _bytesPerSecondCountForAveraging;
}
+ (id) transferState;

@property (readwrite, assign) NSUInteger videoCount;
@property (readwrite, assign) NSUInteger videoTotal;
@property (readwrite, assign) NSUInteger photoCount;
@property (readwrite, assign) NSUInteger photoTotal;
@property (readwrite, assign) NSUInteger photoSetCount;
@property (readwrite, assign) NSUInteger photoSetTotal;
@property (readwrite, assign) unsigned long long byteTotal;
@property (readwrite, assign) unsigned long long byteCount;
@property (readwrite, assign) NSTimeInterval startedTime;
@property (readwrite, assign) NSTimeInterval finishedTime;
@property (readwrite, assign) unsigned long long bytesPerSecondTotal;
@property (readwrite, assign) long bytesPerSecondCountForAveraging;


- (void) setStarted;
- (void) setFinished;




@end
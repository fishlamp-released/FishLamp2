//
//  FLHttpRequestByteCount.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/26/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FLHttpRequestByteCount : NSObject<NSCopying> {
@private
    unsigned long long _byteCount;
    NSTimeInterval _lastTime;
    NSTimeInterval _startTime;
    unsigned long _lastIncrementAmount;
}
+ (id) httpRequestByteCount;

@property (readonly, assign) unsigned long long byteCount;
@property (readonly, assign) NSTimeInterval startTime;
@property (readonly, assign) NSTimeInterval lastTime;
@property (readonly, assign) NSTimeInterval elapsedTime;
@property (readonly, assign) double bytesPerSecond;
@property (readonly, assign) unsigned long lastIncrementAmount;

- (void) setStartTime;
- (void) setFinishTime;

- (void) incrementByteCount:(NSNumber*) amount;

@end

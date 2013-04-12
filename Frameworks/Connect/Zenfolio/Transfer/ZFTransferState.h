//
//  ZFTransferState.h
//  FishLampConnect
//
//  Created by Mike Fullerton on 4/11/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FishLampCocoa.h"

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
    ZFTransferState_t _values;
}
+ (id) transferState;
+ (id) transferState:(ZFTransferState_t) state;

@property (readonly, assign, nonatomic) ZFTransferState_t values;
@end
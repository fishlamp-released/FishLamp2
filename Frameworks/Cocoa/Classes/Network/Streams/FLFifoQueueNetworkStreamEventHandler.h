//
//  FLFifoQueueNetworkStreamEventHandler.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/15/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLNetworkStream.h"
#import "FLDispatchQueue.h"

@interface FLFifoQueueNetworkStreamEventHandler : NSObject<FLNetworkStreamEventHandler> {
@private
    FLFifoAsyncQueue* _asyncQueue;
    FLNetworkStream* _stream;
}

@property (readonly, strong, nonatomic) FLFifoAsyncQueue* asyncQueue;



@end

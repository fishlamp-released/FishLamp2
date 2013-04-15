//
//  FLRunLoopNetworkStreamEventHandler.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/15/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLNetworkStream.h"

@interface FLRunLoopNetworkStreamEventHandler : NSObject {
@private
    __unsafe_unretained NSRunLoop* _runLoop;
    __unsafe_unretained FLNetworkStream* _stream;
    __unsafe_unretained NSThread* _thread;
}

@end

//
//  FLOpenStreamWorker.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLAsyncWorker.h"
#import "FLNetworkStream.h"
#import "FLFinisher.h"

@interface FLStreamWorker : FLContextWorker<FLNetworkStreamDelegate> {
@private
    FLNetworkStream* _networkStream;
    FLFinisher* _finisher;
    id<FLAsyncQueue> _asyncQueue;
}

@property (readwrite, strong, nonatomic) id<FLAsyncQueue> asyncQueue;
@property (readonly, strong, nonatomic) FLFinisher* finisher;
@property (readonly, strong, nonatomic) id networkStream;

- (id) initWithNetworkStream:(FLNetworkStream*) stream;
+ (id) streamWorker:(FLNetworkStream*) stream;

- (void) setFinished;
@end


@interface FLStreamOpener : FLStreamWorker {
@private
}

+ (id) streamOpener:(FLNetworkStream*) stream;
@end

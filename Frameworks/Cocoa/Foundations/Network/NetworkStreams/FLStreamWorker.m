//
//  FLOpenStreamWorker.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLStreamWorker.h"

@interface FLStreamWorker ()
@property (readwrite, strong, nonatomic) FLFinisher* finisher;
@property (readwrite, strong, nonatomic) id networkStream;
@end

@implementation FLStreamWorker

@synthesize networkStream = _networkStream;
@synthesize finisher = _finisher;
@synthesize asyncQueue = _asyncQueue;

- (id) initWithNetworkStream:(FLNetworkStream*) networkStream {
    self = [super init];
    if(self) {
        self.networkStream = networkStream;
    }
    return self;
}

- (void) requestCancel {
    [self.networkStream setError:[NSError cancelError]];
    [self.networkStream closeStream];
}

+ (id) streamWorker:(FLNetworkStream*) networkStream {
   return FLAutorelease([[[self class] alloc] initWithNetworkStream:networkStream]);
}

#if FL_MRC
- (void) dealloc {
    [_networkStream release];
    [_finisher release];
    [super dealloc];
}
#endif

- (void) setFinished {
    NSError* error = [self.networkStream error];
    if(error) {
        [self.finisher setFinishedWithResult:error];
    }
    else {
        [self.finisher setFinished];
    }
}

- (void) networkStreamDidClose:(FLNetworkStream*) networkStream {
    [self setFinished];
}

- (void) startWorking:(FLFinisher*) finisher {
    self.finisher = finisher;
}  

@end


@implementation FLStreamOpener 

+ (id) streamOpener:(FLNetworkStream*) networkStream {
    return FLAutorelease([[[self class] alloc] initWithNetworkStream:networkStream]);
}

- (void) startWorking:(FLFinisher*) finisher {
    [super startWorking:finisher];
    [self.networkStream openStreamWithDelegate:self];
}

- (void) networkStreamDidOpen:(FLNetworkStream*) networkStream {
    [self setFinished];
}

@end

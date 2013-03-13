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
@synthesize dispatcher = _dispatcher;

- (id) initWithNetworkStream:(FLNetworkStream*) stream {
    self = [super init];
    if(self) {
        self.networkStream = stream;
    }
    return self;
}

- (void) requestCancel {
    [self.networkStream setError:[NSError cancelError]];
    [self.networkStream closeStream];
}

+ (id) streamWorker:(FLNetworkStream*) stream {
   return FLAutorelease([[[self class] alloc] initWithNetworkStream:stream]);
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

- (void) streamWillOpen:(FLNetworkStream*) networkStream {
}

- (void) streamDidOpen:(FLNetworkStream*) networkStream {
}

- (void) stream:(FLNetworkStream*) networkStream willCloseWithError:(NSError*) error {
}

- (void) streamDidClose:(FLNetworkStream*) networkStream {
    [self setFinished];
}

- (void) stream:(FLNetworkStream*) stream encounteredError:(NSError*) error {
}

- (void) streamHasBytesAvailable:(FLNetworkStream*) networkStream {
}

- (void) stream:(FLNetworkStream*) stream didReadBytes:(NSNumber*) amountRead {
}

- (void) startWorking:(FLFinisher*) finisher {
    self.finisher = finisher;
}  

@end


@implementation FLStreamOpener 

+ (id) streamOpener:(FLNetworkStream*) stream {
    return FLAutorelease([[[self class] alloc] initWithNetworkStream:stream]);
}

- (void) startWorking:(FLFinisher*) finisher {
    [super startWorking:finisher];
    [self.networkStream openStream];
}

- (void) streamDidOpen:(FLNetworkStream*) networkStream {
    [self setFinished];
}

@end

//
//  FLNetworkStream.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FishLampCore.h"
#import "FLCompatibility.h"
#import "NSObject+Copying.h"
#import "FLTimer.h"

@protocol FLNetworkStreamDelegate;
@class FLFifoAsyncQueue;

typedef enum {
    FLNetworkStreamSecurityNone,
    FLNetworkStreamSecuritySSL
} FLNetworkStreamSecurity;

@interface FLNetworkStream : NSObject<FLTimerDelegate> {
@private
    BOOL _open;
    NSError* _error;
    FLFifoAsyncQueue* _asyncQueue;
    __unsafe_unretained id<FLNetworkStreamDelegate> _delegate;
    FLTimer* _timer;
    FLNetworkStreamSecurity _streamSecurity;
}

@property (readonly, assign, nonatomic) FLNetworkStreamSecurity streamSecurity;

@property (readwrite, assign) id<FLNetworkStreamDelegate> delegate;
@property (readonly, strong) FLFifoAsyncQueue* asyncQueue;

@property (readonly, assign, getter=isOpen) BOOL open;
@property (readonly, strong) NSError* error;

@property (readonly, strong) FLTimer* timer;

- (id) initWithStreamSecurity:(FLNetworkStreamSecurity) security;

- (void) openStreamWithDelegate:(id<FLNetworkStreamDelegate>) delegate 
                     asyncQueue:(FLFifoAsyncQueue*) asyncQueue;

- (void) closeStreamWithError:(NSError*) error;
@end

@protocol FLNetworkStreamDelegate <NSObject>

- (NSTimeInterval) networkStreamGetTimeoutInterval:(FLNetworkStream*) stream;

@optional

- (void) networkStreamWillOpen:(FLNetworkStream*) networkStream;

- (void) networkStreamDidOpen:(FLNetworkStream*) networkStream;

- (void) networkStreamWillClose:(FLNetworkStream*) stream;

- (void) networkStreamDidClose:(FLNetworkStream*) networkStream;

- (void) networkStream:(FLNetworkStream*) networkStream encounteredError:(NSError*) error;

- (void) networkStreamHasBytesAvailable:(FLNetworkStream*) networkStream;

- (void) networkStreamCanAcceptBytes:(FLNetworkStream*) networkStream;

- (void) networkStream:(FLNetworkStream*) networkStream didReadBytes:(NSNumber*) amountRead;

- (void) networkStream:(FLNetworkStream*) networkStream didWriteBytes:(NSNumber*) amountRead;

@end
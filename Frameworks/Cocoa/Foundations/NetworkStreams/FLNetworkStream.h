//
//  FLNetworkStream.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLObservable.h"
#import "FLDispatcher.h"
#import "FLResult.h"
#import "FLCancellable.h"
#import "FLTimeoutTimer.h"
#import "FLDispatchQueue.h"

#define FLNetworkStreamDefaultTimeout 120.0f

@protocol FLNetworkStream <FLObservable, FLCancellable>

@property (readonly, assign) BOOL isOpen;
- (void) openNetworkStream;
- (void) closeNetworkStreamWithResult:(id) result;
@end

@protocol FLWriteStream <FLNetworkStream>
@property (readonly, assign) unsigned long bytesWritten;
- (void) sendData:(NSData*) data;
- (void) sendBytes:(const uint8_t*) bytes length:(unsigned long) length;
@end

@protocol FLReadStream <FLNetworkStream>
@property (readonly, assign) BOOL hasBytesAvailable;
@property (readonly, assign) unsigned long bytesRead;

/** this repeatedly calls readblock until there is no more available bytes, or the STOP is set to YES */
//- (void) readAvailableBytesWithBlock:(void (^)(BOOL* stop)) readblock;

- (NSInteger) appendBytesToMutableData:(NSMutableData*) data;
@end

@protocol FLNetworkStreamObserver <NSObject>
- (void) networkStreamWillOpen:(id<FLNetworkStream>) networkStream;

- (void) networkStreamDidOpen:(id<FLNetworkStream>) networkStream;

- (void) networkStream:(id<FLNetworkStream>) networkStream 
   willCloseWithResult:(FLResult) result;

- (void) networkStream:(id<FLNetworkStream>) networkStream 
    didCloseWithResult:(FLResult) result;

- (void) networkStream:(id<FLNetworkStream>) networkStream
      encounteredError:(NSError*) error;

- (void) networkStreamHasBytesAvailable:(id<FLNetworkStream>) networkStream;

- (void) networkStreamDidReadBytes:(id<FLNetworkStream>) stream;

- (void) networkStreamCanAcceptBytes:(id<FLNetworkStream>) networkStream;

- (void) networkStreamDidWriteBytes:(id<FLNetworkStream>) stream;
@end

@interface FLNetworkStream : FLObservable<FLNetworkStream> {
@private
    BOOL _isOpen;
    BOOL _didClose;
    BOOL _cancelled;;
    FLTimeoutTimer* _timeoutTimer;
}
@property (readonly, strong) FLTimeoutTimer* timeoutTimer;
- (void) touchTimestamp;

@end

@interface FLNetworkStream (CFStream)
- (void) handleStreamEvent:(CFStreamEventType) eventType;
@end

@protocol FLConcreteNetworkStream <NSObject>
- (void) openStream;
- (void) closeStreamWithResult:(id) result;
@end
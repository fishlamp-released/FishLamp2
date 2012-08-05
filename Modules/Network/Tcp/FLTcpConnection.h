//
//  FLTcpConnection.h
//  Fishlamp-Cocoa-Lib
//
//  Created by Mike Fullerton on 4/8/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//
#import "FishLampCore.h"

#import "FLNetworkConnection.h"

#import "FLLinkedList.h"

@class FLTcpConnection;

// call sendData or sendBytes, etc.. from within here.
// see comment about blocking, etc., below
typedef void (^FLTcpConnectionBlock)(FLTcpConnection* connection);

typedef void (^FLTcpConnectionReadBytesBlock)(FLTcpConnection* connection, BOOL* done);

enum {
    FLTcpConnectionStateInfoReadOpen    =  (1 << 10),
    FLTcpConnectionStateInfoWriteOpen   =  (1 << 11),
    FLTcpConnectionStateInfoReading     =  (1 << 12)
};

@interface FLTcpConnection : FLNetworkConnection {
@private
    CFReadStreamRef _readStream;
	CFWriteStreamRef _writeStream;
    CFRunLoopRef _runLoop;
    
    FLLinkedList* _cachedElements;
    FLLinkedList* _writers;
    id _blockingObject;
    
    int32_t _remotePort;
    int32_t _localPort;
    NSString* _remoteHostAddress;
}

+ (FLTcpConnection*) tcpConnection;

@property (readonly, assign, nonatomic) CFReadStreamRef readStream;
@property (readonly, assign, nonatomic) CFWriteStreamRef writeStream;

@property (readwrite, assign, nonatomic) int32_t remotePort;
@property (readwrite, assign, nonatomic) int32_t localPort;

@property (readwrite, retain) NSString* remoteHostAddress;

// either a request or a response handler can stop request processing,
// but whoever turns on the blocking is responsible for turning it off.
@property (readonly, assign) BOOL isBlockingRequests;

// must be the same object to block/unblock. Nested blocking is not supported.
- (void) blockRequestsWithObject:(id) object;
- (void) unblockRequestsWithObject:(id) object; 

- (void) queueWriteBlock:(FLTcpConnectionBlock) writer;
- (void) removeAllWriters;

// call these from within your sendBlock
- (void) sendData:(NSData*) data;
- (void) sendBytes:(const uint8_t*) bytes length:(NSUInteger) length;

- (NSUInteger) readAvailableBytes:(void*) bytes 
                        maxLength:(NSUInteger) maxLength;


/// @brief this blocks until read. 
/// note that it will throw an exception if the connection times out
/// or something else terminates the connection.
- (void) readBytes:(void*) bytes 
    numBytesToRead:(NSUInteger) numBytesToRead;
                    
// EXPERIMENT(MF)
//- (NSData*) readBytes:(NSUInteger) maxLength;
//- (NSData*) readAllAvailableBytes;

@end

@interface FLTcpConnection (Protected)
- (void) setOpenedStreams:(CFWriteStreamRef) writeStream
               readStream:(CFReadStreamRef) readStream;
@end


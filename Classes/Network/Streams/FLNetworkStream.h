//
//  FLNetworkStream.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLByteBuffer.h"

#define kRunLoopMode kCFRunLoopDefaultMode

@protocol FLNetworkStream <NSObject>
@property (readwrite, assign) id delegate;
@property (readonly, assign) BOOL isOpen;
@property (readonly, assign) BOOL isRunning;
@property (readonly, strong) NSError* error;
- (void) openStream;
- (void) closeStream;
@end

@protocol FLReadStream <FLNetworkStream>
@property (readonly, assign) BOOL hasBytesAvailable;
@property (readonly, assign) unsigned long bytesRead;
/** this repeatedly calls readblock until there is no more available bytes, or the STOP is set to YES */
- (void) readAvailableBytesWithBlock:(void (^)(BOOL* stop)) readblock;

- (void) readBytes:(void*) bytes
    numBytesToRead:(NSUInteger) amount;

- (NSUInteger) readAvailableBytes:(void*) bytes 
                        maxLength:(NSUInteger) maxLength;

- (void) readAvailableBytesWithByteBuffer:(FLByteBuffer*) buffer;

/** chunk size depends on what your doing... */
- (NSUInteger) appendAvailableBytesToData:(NSMutableData*) data 
                                chunkSize:(NSUInteger) chunkSize;
@end

@protocol FLWriteStream <FLNetworkStream>
@property (readonly, assign) unsigned long bytesWritten;
- (void) sendData:(NSData*) data;
- (void) sendBytes:(const uint8_t*) bytes length:(unsigned long) length;
@end

@interface FLNetworkStream : NSObject<FLNetworkStream> {
@private
    __unsafe_unretained id _delegate;
    __unsafe_unretained NSThread* _thread;
    CFRunLoopRef _runLoop;
    BOOL _isOpen;
}
@property (readonly, assign) NSThread* thread;
@property (readonly, assign) CFRunLoopRef runLoop;

- (void) forwardStreamEventToDelegate:(CFStreamEventType) eventType;
+ (NSError *) errorFromStreamError:(CFStreamError)streamError;

@end


@protocol FLNetworkStreamDelegate <NSObject>
@optional

- (void) networkStreamDidOpen:(id<FLNetworkStream>) networkStream;
- (void) networkStreamDidClose:(id<FLNetworkStream>) networkStream;

// got error
- (void) networkStreamEncounteredError:(id<FLNetworkStream>) networkStream;

@end


@protocol FLReadStreamDelegate <NSObject>
- (void) readStreamHasBytesAvailable:(id<FLReadStream>) networkStream;
- (void) readStreamDidReadBytes:(id<FLReadStream>) stream;
@end

@protocol FLWriteStreamDelegate <NSObject>
- (void) writeStreamCanAcceptBytes:(id<FLWriteStream>) networkStream;
- (void) writeStreamDidWriteBytes:(id<FLWriteStream>) stream;
@end
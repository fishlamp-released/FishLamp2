//
//  FLTcpConnection.m
//  Fishlamp-Cocoa-Lib
//
//  Created by Mike Fullerton on 4/8/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLTcpConnection.h"
#if IOS
#import <CFNetwork/CFNetwork.h>
#else
#import <CoreServices/CoreServices.h>
#endif

#import "NSArray+FLExtras.h"
#import "_FLNetworkConnection.h"
#import "FLBlockLinkedListElement.h"


@implementation FLTcpConnection

@synthesize readStream = _readStream;
@synthesize writeStream = _writeStream;
@synthesize remotePort = _remotePort;
@synthesize localPort = _localPort;
@synthesize remoteHostAddress = _remoteHostAddress;

- (id) init {
    self = [super init];
    if(self) {
        _writers = [[FLLinkedList alloc] init];
        _cachedElements = [[FLLinkedList alloc] init];
    }
    return self;
}

+ (FLTcpConnection*) tcpConnection {
    return FLReturnAutoreleased([[[self class] alloc] init]); 
}

- (FLBlockLinkedListElement*) _containerForObject {
    FLBlockLinkedListElement* element = [_cachedElements removeFirstObject];
    if(!element) {
        element = [FLBlockLinkedListElement blockLinkedListElement];
    }
    return element;
}

- (void) dealloc {
    [self closeNetworkStreams];
#if FL_DEALLOC
    FLRelease(_remoteHostAddress);
    FLRelease(_cachedElements);
    FLRelease(_writers);
    FLRelease(_blockingObject);
    FLSuperDealloc();
#endif
}


- (void) _cacheContainer:(FLBlockLinkedListElement*) container {
    container.block = nil;
    [_cachedElements addObject:container];
}

- (void) _removeAllFromList:(FLLinkedList*) linkedList {
    FLBlockLinkedListElement* walker = linkedList.firstObject;
    while(walker) {
        FLBlockLinkedListElement* container = walker;

        walker = [walker nextObjectInLinkedList];
        
        FLRetain(container);
        [linkedList removeObject:container];
        [self _cacheContainer:container];
        FLRelease(container);
    }
}


#define kRunLoopMode kCFRunLoopDefaultMode

- (void) closeNetworkStreams {
    [super closeNetworkStreams];

    if(_readStream) {
        CFReadStreamSetClient(_readStream, kCFStreamEventNone, NULL, NULL);
        CFReadStreamUnscheduleFromRunLoop(_readStream, _runLoop, kRunLoopMode);
        CFReadStreamClose(_readStream);
        CFRelease(_readStream);
        _readStream = nil;
    }
    if(_writeStream) {
        CFWriteStreamSetClient(_writeStream, kCFStreamEventNone, NULL, NULL);
        CFWriteStreamUnscheduleFromRunLoop(_writeStream, _runLoop, kRunLoopMode);
        CFWriteStreamClose(_writeStream);
        CFRelease(_writeStream);
        _writeStream = nil;
    }

    FLReleaseWithNil(_blockingObject);
    
    _runLoop = nil;
}

- (void) setOpenedStreams:(CFWriteStreamRef) writeStream
               readStream:(CFReadStreamRef) readStream {
 
    _readStream = readStream;
    _writeStream = writeStream;
    _runLoop = CFRunLoopGetCurrent();
                 
    if(_readStream && _writeStream) {
        CFStreamClientContext ctxt = {0, (__fl_bridge void*) self, NULL, NULL, NULL};
    
        CFOptionFlags flags =               
                kCFStreamEventOpenCompleted | 
                kCFStreamEventHasBytesAvailable | 
                kCFStreamEventCanAcceptBytes |
                kCFStreamEventEndEncountered | 
                kCFStreamEventErrorOccurred;

        CFReadStreamSetClient(_readStream, flags, ReadStreamClientCallBack, &ctxt);
        CFReadStreamScheduleWithRunLoop(_readStream, _runLoop, kRunLoopMode);

        CFWriteStreamSetClient(_writeStream, flags, WriteStreamClientCallBack, &ctxt);
        CFWriteStreamScheduleWithRunLoop(_writeStream, _runLoop, kRunLoopMode);

        CFReadStreamOpen(_readStream);
        CFWriteStreamOpen(_writeStream);
    }
    else {
        [self closeNetworkStreams];
    }
}


- (BOOL) isBlockingRequests {
    return _blockingObject != nil;
}

- (void) blockRequestsWithObject:(id) object {
    FLAssert(_blockingObject == nil, @"alreadying blocking with an object");
    FLAssignObject(_blockingObject, object);
}

- (void) unblockRequestsWithObject:(id) object {
    FLAssert(object == _blockingObject, @"trying to unblock with wrong object");
    FLReleaseWithNil(_blockingObject);
}

- (void) _checkReadState {
    if(!FLBitTest(self.connectionStateFlags, FLTcpConnectionStateInfoReading) && 
        CFReadStreamHasBytesAvailable(_readStream)) {
        [self visitObservers:^(FLNetworkConnectionObserver* observer, BOOL* stop) { \
            FLNotifyObserver(self, observer, FLNetworkEventWillReadData);
        }];
    }
}

- (void) handleReadStreamEvent:(CFStreamEventType) eventType {

    FLAssert([NSThread currentThread] == self.thread, @"tcp operation on wrong thread");

#if TRACE
    FLDebugLog(@"Read Stream got event %d", eventType);
#endif
    switch (eventType)  {
        case kCFStreamEventOpenCompleted:
            self.connectionStateFlags = FLBitSet(self.connectionStateFlags, FLTcpConnectionStateInfoReadOpen);
            if(self.isConnectionOpen) {
                 [self connectionDidOpen];
            }
            break;
        
        case kCFStreamEventNone:
        case kCFStreamEventHasBytesAvailable:
            [self performBlock:^{
                [self _checkReadState];
                }
             onThread:self.thread];
            break;
            
        case kCFStreamEventErrorOccurred: {
            CFErrorRef error = CFReadStreamCopyError(self.readStream);
            self.error = (NSError*) error;
            CFRelease(error);
            }
            break;

        case kCFStreamEventEndEncountered:
            [self closeConnection];
            break;
            
        case kCFStreamEventCanAcceptBytes: // should never get this on read stream.
            return; // skip activity update
            break;
    }
    [self updateLastActivityTimestamp];
}

- (void) handleWriteStreamEvent:(CFStreamEventType) eventType {

    FLAssert([NSThread currentThread] == self.thread, @"tcp operation on wrong thread");

#if TRACE
    FLDebugLog(@"Write Stream got event %d", eventType);
#endif
     switch (eventType) {
            
        case kCFStreamEventEndEncountered: // TODO: handle this case?
            [self closeConnection];
            break;
            
        case kCFStreamEventOpenCompleted:
            self.connectionStateFlags = FLBitSet(self.connectionStateFlags, FLTcpConnectionStateInfoWriteOpen);
            if(self.isConnectionOpen) {
                [self connectionDidOpen];
            }
        
        break;
            
        case kCFStreamEventErrorOccurred:{
            [self updateLastActivityTimestamp];
            CFErrorRef error = CFWriteStreamCopyError(self.writeStream);
            self.error = (NSError*) error;
            CFRelease(error);
            break;
        }

        case kCFStreamEventCanAcceptBytes:
            [self sendDataInQueue];
            break;
            
        case kCFStreamEventHasBytesAvailable: // should never get this event on write stream
        case kCFStreamEventNone:
            return; // skip activity update
            break;
    }
    [self updateLastActivityTimestamp];
}


static void ReadStreamClientCallBack(CFReadStreamRef readStream, CFStreamEventType eventType, void *clientCallBackInfo) {
    FLTcpConnection* connection = (__fl_bridge FLTcpConnection*) clientCallBackInfo;
    FLCAssertIsNotNil(connection);
    [connection handleReadStreamEvent:eventType];
}

static void WriteStreamClientCallBack(CFWriteStreamRef readStream, CFStreamEventType eventType, void *clientCallBackInfo) {
    FLTcpConnection* connection = (__fl_bridge FLTcpConnection*) clientCallBackInfo;
    FLCAssertIsNotNil(connection);
    [connection handleWriteStreamEvent:eventType];
}

- (void) sendBytes:(const uint8_t*) bytes length:(NSUInteger) length {

    FLAssert([NSThread currentThread] == self.thread, @"tcp operation on wrong thread");
 
    FLAssertIsNotNil(_writeStream);

    FLNetworkConnectionByteCount byteCount = self.writeByteCount;
    byteCount.lastChunkCount = 0;

    const uint8_t *buffer = bytes;
    while(length > 0) {
        CFIndex amt = CFWriteStreamWrite(_writeStream, buffer, length);
        if(amt <= 0) {   
            FLThrowErrorCode((NSString*) kCFErrorDomainCFNetwork, kCFURLErrorBadServerResponse, NSLocalizedString(@"writing networkbytes failed: %d", result));
        }
        
        length -= amt;
        buffer += amt;
        byteCount.lastChunkCount += amt;
    }
    
    byteCount.totalCount += byteCount.lastChunkCount;
    self.writeByteCount = byteCount;
    
    [self updateLastActivityTimestamp];
}

- (void) sendData:(NSData*) data {
    [self sendBytes:data.bytes length:data.length];
}


- (NSUInteger) readAvailableBytes:(void*) bytes 
                        maxLength:(NSUInteger) maxLength {

    FLAssert([NSThread currentThread] == self.thread, @"tcp operation on wrong thread");

#if DEBUG   
    uint8_t* lastBytePtr = bytes + maxLength;
#endif

    uint8_t* readPtr = bytes;
    NSUInteger readTotal = 0;
    while(maxLength > 0 && CFReadStreamHasBytesAvailable(_readStream)) {   

#if DEBUG
        FLAssert(readPtr + maxLength <= lastBytePtr, @"buffer overrun!!!! Warning warning warning!!!!");
#endif

        NSInteger result = CFReadStreamRead(_readStream, readPtr, maxLength);
        
        if(result <= 0) {   
// TODO: this isn't the right error to throw probably.
            FLThrowErrorCode((NSString*) kCFErrorDomainCFNetwork, kCFURLErrorBadServerResponse, NSLocalizedString(@"Read networkbytes failed: %d", result));
        }
        
        readPtr += result;
        maxLength -= result;
        
        readTotal += result;
    }

    FLNetworkConnectionByteCount byteCount = self.readByteCount;
    byteCount.lastChunkCount = readTotal;
    byteCount.totalCount += readTotal;
    self.readByteCount = byteCount;

    [self updateLastActivityTimestamp];
    
    return readTotal;


}

- (void) readBytes:(void*) bytes 
    numBytesToRead:(NSUInteger) amount  {

    FLAssert([NSThread currentThread] == self.thread, @"tcp operation on wrong thread");
    
    FLAssert(!FLBitTest(self.connectionStateFlags, FLTcpConnectionStateInfoReading), @"already reading!");

    NSUInteger amountRead = [self readAvailableBytes:bytes maxLength:amount];
    if(amountRead == amount) {
        return;
    }    

    @try {

        self.connectionStateFlags = FLBitSet(self.connectionStateFlags, FLTcpConnectionStateInfoReading);
        
        void* position = bytes + amountRead;
        
        // note that this can time out.
        while(amountRead < amount && [self waitOnceForRunLoop]) {
            if(CFReadStreamHasBytesAvailable(_readStream)) {
                NSUInteger chunkSize = [self readAvailableBytes:position maxLength:amount - amountRead];
                position += chunkSize;
                amountRead += chunkSize;
            }
        }

    }
    @finally {
        self.connectionStateFlags = FLBitClear(self.connectionStateFlags, FLTcpConnectionStateInfoReading);
    }

    if(amountRead != amount) {
        FLThrowCancelException();
    }
    
    [self performBlock:^{
        [self _checkReadState];
        }
     onThread:self.thread];

}

// EXPERIMENT(MF)

- (NSData*) readBytes:(NSUInteger) maxLength {

// TODO: not sure this even makes sense

    NSMutableData* data = [NSMutableData dataWithLength:2048];

//    NSInteger amount = 0;
//    while(maxLength > 0 && CFReadStreamHasBytesAvailable(_readStream))
//    {   
//        CFIndex result = CFReadStreamRead(_readStream, data.bytes + amount, maxLength);
//        if(result <= 0) 
//        {   
//            FLThrowErrorCode((NSString*) kCFErrorDomainCFNetwork, kCFURLErrorBadServerResponse, NSLocalizedString(@"Read networkbytes failed: %d", result));
//        }
//        
//        maxLength -= amount;
//        amount += result;
//    }
//
//    [self updateLastActivityTimestamp];
//
//
//
//    uint8_t bytes[512];
//    
//    NSUInteger amount = 0;
//    
//    NSInteger amount = [self readBytes:bytes maxLength:maxLength];
//    
    return data;
}

- (NSData*) readAllAvailableBytes {
// TODO: not sure this even makes sense

    return nil;
}

- (void) sendDataInQueue {

    FLPerformBlockInAutoreleasePool(^{
        
        while(!self.isBlockingRequests){
            FLBlockLinkedListElement* container = nil;
            @synchronized(self) {
                if(_writers.count){
                    container = [_writers removeFirstObject];
                    FLRetain(container);
                }
            }
            if(container) {
                FLTcpConnectionBlock writer = (FLTcpConnectionBlock) container.block;
                if(writer) {
                    writer(self);
                }
                FLRelease(container);
            }
            else {
                break;
            }
        }
    });
}

- (void) queueWriteBlock:(FLTcpConnectionBlock) writer {
    @synchronized(self) {
        FLBlockLinkedListElement* element = [self _containerForObject];
        element.block = (FLGenericBlock) writer;
        [_writers addObject:element];
        if(self.isConnectionOpen) {
            [self visitConnection:^(id connection) {
                [connection sendDataInQueue];
                }];
        }
    }
}

- (void) removeAllWriters {   
    @synchronized(self) {
        [self _removeAllFromList:_writers];
    }
}

- (BOOL) isConnectionOpen {
    return FLBitTest(self.connectionStateFlags, FLTcpConnectionStateInfoReadOpen | FLTcpConnectionStateInfoWriteOpen);
}

@end


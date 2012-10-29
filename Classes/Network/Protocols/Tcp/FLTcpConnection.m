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
#import "FLNetworkConnection_Internal.h"
#import "FLBlockLinkedListElement.h"
#import "FLTcpConnection_Internal.h"
#import "FLTcpRequest.h"
#import "FLTcpStream.h"

@interface FLTcpConnection ()
@property (readwrite, assign, nonatomic) int32_t remotePort;
@property (readwrite, strong) NSString* remoteHostAddress;
@end

@implementation FLTcpConnection

@synthesize remotePort = _remotePort;
@synthesize remoteHostAddress = _remoteHost;

- (id) init {
    self = [super init];
    if(self) {
        _requests = [[FLLinkedList alloc] init];
        _additions = [[FLLinkedList alloc] init];
        _writer = [[FLTcpConnectionWriter alloc] initWithConnection:self];
        _reader = [[FLTcpConnectionReader alloc] initWithConnection:self];
    }
    return self;
}

- (id) initWithRemoteHost:(NSString*) remoteHost remotePort:(int32_t) remotePort {
    self = [self init];
    if(self) {
        self.remoteHostAddress = remoteHost;
        self.remotePort = remotePort;
    }
    
    return self;
}

+ (FLTcpConnection*) tcpConnection {
    return FLReturnAutoreleased([[[self class] alloc] init]); 
}

+ (FLTcpConnection*) tcpConnection:(NSString*) remoteHost remotePort:(int32_t) remotePort {
    return FLReturnAutoreleased([[[self class] alloc] initWithRemoteHost:remoteHost remotePort:remotePort]);
}

- (void) dealloc {
#if FL_NO_ARC
    FLRelease(_writer);
    FLRelease(_reader);
    FLRelease(_remoteHost);
    FLRelease(_additions);
    FLRelease(_requests);
    FLRelease(_blockingObject);
    FLSuperDealloc();
#endif
}

- (BOOL) isBlockingRequests {
    return _blockingObject != nil;
}

- (void) blockRequestsWithObject:(id) object {
    FLAssert_v(_blockingObject == nil, @"alreadying blocking with an object");
    FLAssignObject(_blockingObject, object);
}

- (void) unblockRequestsWithObject:(id) object {
    FLAssert_v(object == _blockingObject, @"trying to unblock with wrong object");
    FLReleaseWithNil(_blockingObject);
}

- (void) _writeAvailableBytes {
    for(FLTcpRequest* request in _requests.mutableEnumerator) {
        if(request && request.wantsWrite) {
            request.wantsWrite = [request writeData:_writer];
        }
        
        if(!request.wantsWrite && !request.wantsRead) {
            [_requests removeObject:request];
        }
    }
}

- (void) _readAvailableBytes {
   [self.networkStream.readStream readAvailableBytesWithBlock:^(BOOL* stop) {
        *stop = YES;
        
        for(FLTcpRequest* request in _requests) {
            if(request && request.wantsRead) {
                request.wantsRead = [request readData:_reader];
                *stop = NO;
                break;
            }
            
            if(!request.wantsWrite && !request.wantsRead) {
                [_requests removeObject:request];
            }
        }
    }];
}

- (void) _updateQueue {

    BOOL isOpen = NO;
    @synchronized (self) {
        [_requests addObjectsFromList:_additions];
        isOpen = [self.networkStream isOpen];
    }

    if(isOpen) {
        [self _readAvailableBytes];
        [self _writeAvailableBytes];
    }
}

- (void) updateQueue {
    NSThread* thread = self.thread;
    if(thread) {
        [self performSelector:@selector(_updateQueue) onThread:thread withObject:nil waitUntilDone:NO];
    }
}

- (void) readStreamHasBytesAvailable:(id<FLNetworkStream>) networkStream {  
    [self touchTimestamp];
    [self updateQueue];
}

- (void) addRequest:(FLTcpRequest*) request {
    @synchronized(self) {
        [_additions addObject:request];
    }
    [self updateQueue];
}

//- (void) removeAllWriters {   
//    @synchronized(self) {
//        [self _removeAllFromList:_writers];
//    }
//}


- (void) networkStreamDidClose:(id<FLNetworkStream>)networkStream {
    [super networkStreamDidClose:networkStream];
    
    FLReleaseWithNil(_blockingObject);
  

}





@end


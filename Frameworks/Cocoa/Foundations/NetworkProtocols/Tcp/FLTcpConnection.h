//
//  FLTcpConnection.h
//  Fishlamp-Cocoa-Lib
//
//  Created by Mike Fullerton on 4/8/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//
#import "FLCore.h"
#import "FLTcpConnectionWriter.h"
#import "FLTcpConnectionReader.h"
#import "FLTcpRequest.h"
#import "FLLinkedList.h"
#import "FLObservable.h"

@interface FLTcpConnection : FLObservable {
@private
    FLLinkedList* _requests;
    FLLinkedList* _additions;
    id _blockingObject;
    
    int32_t _remotePort;
    NSString* _remoteHost;
    
    FLTcpConnectionWriter* _writer;
    FLTcpConnectionReader* _reader;
}

- (id) initWithRemoteHost:(NSString*) remoteHost
               remotePort:(int32_t) remotePort;

+ (FLTcpConnection*) tcpConnection:(NSString*) remoteHost
                        remotePort:(int32_t) remotePort;

@property (readonly, assign, nonatomic) int32_t remotePort;
@property (readonly, strong) NSString* remoteHostAddress;

// either a request or a response handler can stop request processing,
// but whoever turns on the blocking is responsible for turning it off.
@property (readonly, assign) BOOL isBlockingRequests;

// must be the same object to block/unblock. Nested blocking is not supported.
- (void) blockRequestsWithObject:(id) object;
- (void) unblockRequestsWithObject:(id) object; 

- (void) addRequest:(FLTcpRequest*) request;


@end


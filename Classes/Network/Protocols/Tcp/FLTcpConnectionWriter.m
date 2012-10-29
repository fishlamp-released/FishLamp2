//
//  FLTcpConnectionWriter.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/4/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLTcpConnectionWriter.h"
#import "FLTcpConnection_Internal.h"

@implementation FLTcpConnectionWriter

@synthesize connection =_connection;

- (id) initWithConnection:(FLTcpConnection*) connection {
    self = [super init];
    if(self) {
        _connection = connection;
    }
    return self;
}

- (void) sendBytes:(const uint8_t*) bytes length:(NSUInteger) length {
    [_connection.networkStream.writeStream sendBytes:bytes length:length];
}

- (void) sendData:(NSData*) data {
    [_connection.networkStream.writeStream sendBytes:data.bytes length:data.length];
}


@end

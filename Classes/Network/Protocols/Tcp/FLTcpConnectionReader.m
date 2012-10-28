//
//  FLTcpConnectionReader.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/4/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLTcpConnectionReader.h"
#import "FLTcpConnection_Internal.h"

@implementation FLTcpConnectionReader

@synthesize connection = _connection;

- (id) initWithConnection:(FLTcpConnection*) connection {
    self = [super init];
    if(self) {
        _connection = connection;
    }
    return self;
}

- (NSUInteger) readAvailableBytes:(void*) bytes 
                        maxLength:(NSUInteger) maxLength {

    return [_connection.networkStream readAvailableBytes:bytes maxLength:maxLength];
}

- (NSUInteger) readAvailableData:(NSMutableData*) mutableData
                    maxLength:(NSUInteger) maxLength {

    NSData* data = [self readAvailableData:maxLength];
    [mutableData appendData:data];
    return data.length;
}

- (void) readBytes:(void*) bytes
    numBytesToRead:(NSUInteger) amount  {

    [_connection.networkStream readBytes:bytes numBytesToRead:amount];
}

- (NSData*) readAvailableData:(NSUInteger) maxLength {
    NSMutableData* data = [NSMutableData dataWithCapacity:maxLength];
    data.length = [_connection.networkStream readAvailableBytes:data.mutableBytes maxLength:maxLength];
    return data;
}

- (NSData*) readData:(NSUInteger) amountToRead {
    NSMutableData* data = [NSMutableData dataWithCapacity:amountToRead];
    [_connection.networkStream readBytes:data.mutableBytes numBytesToRead:amountToRead];
    data.length = amountToRead;
    return data;
}

- (void) readData:(NSMutableData*) bytes
    numBytesToRead:(NSUInteger) numBytesToRead {
    [bytes appendData:[self readData:numBytesToRead]];
}


@end

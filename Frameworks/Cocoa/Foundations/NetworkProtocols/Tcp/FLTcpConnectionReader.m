//
//  FLTcpConnectionReader.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/4/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLTcpConnectionReader.h"
#import "FLTcpConnection_Internal.h"
#import "FLReadStream.h"

@implementation FLTcpConnectionReader

@synthesize connection = _connection;

- (id) initWithConnection:(FLTcpConnection*) connection {
    self = [super init];
    if(self) {
        _connection = connection;
    }
    return self;
}

- (FLReadStream*) readStream {
//    return [((id)self.connection.networkStream) readStream];

return nil;
}

- (NSUInteger) readAvailableBytes:(void*) bytes 
                        maxLength:(NSUInteger) maxLength {

//    return [self.readStream readAvailableBytes:bytes maxLength:maxLength];

return 0;
}

- (NSUInteger) readAvailableData:(NSMutableData*) mutableData
                    maxLength:(NSUInteger) maxLength {

//    NSData* data = [self readAvailableData:maxLength];
//    [mutableData appendData:data];
//    return data.length;

return 0;
}

- (void) readBytes:(void*) bytes
    numBytesToRead:(NSUInteger) amount  {

//    [self.readStream readBytes:bytes numBytesToRead:amount];
}

- (NSData*) readAvailableData:(NSUInteger) maxLength {
//    NSMutableData* data = [NSMutableData dataWithCapacity:maxLength];
//    data.length = [self.readStream readAvailableBytes:data.mutableBytes maxLength:maxLength];
//    return data;

return nil;
}

- (NSData*) readData:(NSUInteger) amountToRead {
//    NSMutableData* data = [NSMutableData dataWithCapacity:amountToRead];
//    [self.readStream readBytes:data.mutableBytes numBytesToRead:amountToRead];
//    data.length = amountToRead;
//    return data;

return nil;
}

//- (void) readData:(NSMutableData*) bytes
////    numBytesToRead:(NSUInteger) numBytesToRead {
////    [bytes appendData:[self readData:numBytesToRead]];
//}


@end

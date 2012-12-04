//
//  FLTcpConnectionWriter.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/4/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FLTcpConnection;

@interface FLTcpConnectionWriter : NSObject {
@private
    __unsafe_unretained FLTcpConnection* _connection;
}

@property (readonly, assign, nonatomic) FLTcpConnection* connection;

- (void) sendData:(NSData*) data;
- (void) sendBytes:(const uint8_t*) bytes length:(NSUInteger) length;

@end
//
//  FLTcpConnectionReader.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/4/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FLTcpConnection;

@interface FLTcpConnectionReader : NSObject {
@private
    __unsafe_unretained FLTcpConnection* _connection;
}

@property (readonly, assign) FLTcpConnection* connection;

// these read as much as they can an return immediately.

//- (NSUInteger) readAvailableBytes:(void*) bytes
//                        maxLength:(NSUInteger) maxLength;
//
//- (NSUInteger) readAvailableData:(NSMutableData*) bytes
//                        maxLength:(NSUInteger) maxLength;
//
//- (NSData*) readAvailableData:(NSUInteger) maxLength;
//
///// @brief this blocks until read.
///// note that it will throw an exception if the connection times out
///// or something else terminates the connection.
//
//- (void) readBytes:(void*) bytes 
//    numBytesToRead:(NSUInteger) numBytesToRead;
//
//- (void) readData:(NSMutableData*) data
//    numBytesToRead:(NSUInteger) numBytesToRead;
//
//- (NSData*) readData:(NSUInteger) amountToRead;

@end
//
//  FLWriteStream.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLNetworkStream.h"
#import "FLNetworkStream.h"

@protocol FLWriteStream <FLNetworkStream>
@property (readonly, assign) unsigned long bytesWritten;
- (void) sendData:(NSData*) data;
- (void) sendBytes:(const uint8_t*) bytes length:(unsigned long) length;
@end

@protocol FLWriteStreamDelegate <NSObject>
- (void) writeStreamCanAcceptBytes:(id<FLWriteStream>) networkStream;
- (void) writeStreamDidWriteBytes:(id<FLWriteStream>) stream;
@end


@interface FLWriteStream : FLNetworkStream<FLWriteStream> {
@private
 	CFWriteStreamRef _streamRef;
}
@property (readonly, assign) CFWriteStreamRef streamRef;

- (id) initWithWriteStream:(CFWriteStreamRef) streamRef;
+ (id) writeStream:(CFWriteStreamRef) streamRef;

@end


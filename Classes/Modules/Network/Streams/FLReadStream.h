//
//  FLReadStream.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLNetworkStream.h"
#import "FLNetworkStream.h"
#import "FLByteBuffer.h"
#import "FLAbstractNetworkStream.h"

@protocol FLReadStream <NSObject>
@property (readonly, assign) BOOL hasBytesAvailable;
@property (readonly, assign) unsigned long bytesRead;

/** this repeatedly calls readblock until there is no more available bytes, or the STOP is set to YES */
- (void) readAvailableBytesWithBlock:(void (^)(BOOL* stop)) readblock;

- (NSInteger) appendBytesToMutableData:(NSMutableData*) data;

@end

@interface FLReadStream : FLAbstractNetworkStream<FLReadStream, FLConcreteNetworkStream>  {
@private
    CFReadStreamRef _streamRef;
    BOOL _reading;
    NSError* _error;
}
@property (readonly, assign, nonatomic) CFReadStreamRef streamRef;

- (id) initWithReadStream:(CFReadStreamRef) writeStream;

+ (id) readStream:(CFReadStreamRef) writeStream;

@end

@protocol FLReadStreamDelegate <NSObject>
- (void) readStreamHasBytesAvailable:(id<FLReadStream>) networkStream;
- (void) readStreamDidReadBytes:(id<FLReadStream>) stream;
@end
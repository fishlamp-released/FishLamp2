//
//  FLReadStream.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//
#import "FLCocoaRequired.h"
#import "FLNetworkStream.h"
#import "FLNetworkStreamSink.h"

@protocol FLReadStreamDelegate;

@interface FLReadStream : FLNetworkStream  {
@private
    CFReadStreamRef _streamRef;
    FLNetworkStreamSink* _sink;
}
@property (readwrite, strong, nonatomic) FLNetworkStreamSink* sink;
@property (readonly, assign, nonatomic) CFReadStreamRef streamRef;

// info
@property (readonly, assign) BOOL hasBytesAvailable;
@property (readonly, assign) unsigned long bytesRead;

// reading data from stream 
- (NSUInteger) readBytes:(uint8_t*) bytes 
               maxLength:(NSUInteger) maxLength;

- (CFReadStreamRef) createReadStreamRef;

@end

//
//  FLReadStream.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//
#import "FLCocoaRequired.h"
#import "FLNetworkStream.h"

@protocol FLReadStreamDelegate;

@interface FLReadStream : FLNetworkStream  {
@private
    CFReadStreamRef _streamRef;
}

// CFStream
@property (readwrite, assign, nonatomic) CFReadStreamRef streamRef;

// info
@property (readonly, assign) BOOL hasBytesAvailable;
@property (readonly, assign) unsigned long bytesRead;

// reading data from stream 
- (NSUInteger) readBytes:(uint8_t*) bytes 
               maxLength:(NSUInteger) maxLength;


@end

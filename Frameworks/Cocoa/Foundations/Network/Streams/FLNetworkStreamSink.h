//
//  FLNetworkStreamSink.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/15/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLNetworkStream.h"

@interface FLNetworkStreamSink : NSObject<FLNetworkStreamDelegate> {
@private
    id<FLNetworkStreamDelegate> _delegate;
}
@property (readwrite, nonatomic, assign) id<FLNetworkStreamDelegate> delegate;

+ (id) networkStreamSink;

// results, once the stream is closed.
@property (readonly, strong, nonatomic) NSData* data;
@property (readonly, strong, nonatomic) NSURL* fileURL;

@end

/// read into a NSData
@interface FLDataStreamSink : FLNetworkStreamSink  {
@private
    NSMutableData* _responseData;
    NSData* _data;
}

+ (id) dataStreamSink;
@end

/// read into a file with a stream
#define FLFileResponseReceiverFileBufferSize 32768
@interface FLFileStreamSink : FLNetworkStreamSink  {
@private
    NSURL* _fileURL;
    NSOutputStream* _outputStream;
    uint8_t _bufferHunk[FLFileResponseReceiverFileBufferSize];
}

- (id) initWithFileURL:(NSURL*) fileURL;
+ (id) fileStreamSink:(NSURL*) fileURL;
@end


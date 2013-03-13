//
//  FLResponseReceiver.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/4/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FLReadStream;

@protocol FLResponseReceiver <NSObject>
@property (readonly, strong, nonatomic) NSData* data;
@property (readonly, strong, nonatomic) NSInputStream* readStream;
@property (readonly, strong, nonatomic) NSURL* fileURL;
@property (readonly, assign, getter=isClosed) BOOL closed;

// internal, don't call these.
- (void) openReceiver;
- (void) readBytesFromStream:(FLReadStream*) stream;
- (NSError*) closeReceiverWithError:(NSError*) error;
@end

/// concrete base case
@interface FLResponseReceiver : NSObject<FLResponseReceiver> {
@private
    BOOL _closed;
}
@property (readwrite, assign, getter=isClosed) BOOL closed;

- (void) appendBytes:(const void *)bytes length:(NSUInteger)length;
@end

/// read into a NSData
@interface FLDataResponseReceiver : FLResponseReceiver  {
@private
    NSMutableData* _responseData;
    NSData* _data;
}

+ (id) dataResponseReceiver;
@end

/// read into a file with a stream
#define FLFileResponseReceiverFileBufferSize 32768
@interface FLFileResponseReceiver : FLResponseReceiver  {
@private
    NSURL* _fileURL;
    NSOutputStream* _outputStream;
    uint8_t _bufferHunk[FLFileResponseReceiverFileBufferSize];
}

- (id) initWithFileURL:(NSURL*) fileURL;
+ (id) fileResponseReceiver:(NSURL*) fileURL;
@end


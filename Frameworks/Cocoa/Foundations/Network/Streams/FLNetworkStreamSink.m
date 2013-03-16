//
//  FLNetworkStreamSink.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/15/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLNetworkStreamSink.h"
#import "FLReadStream.h"

@interface FLNetworkStreamSink ()
// internal, don't call these.
@end


@implementation FLNetworkStreamSink

@synthesize delegate = _delegate;

+ (id) networkStreamSink {
    return FLAutorelease([[[self class] alloc] init]);
}

//- (id) initWithReadStream:(FLReadStream*) readStream {
//    self = [super init];
//    if(self) {
//        _readStream = FLRetain(readStream);
//        [_readStream addListener:readStream];
//    }
//    return self;
//}
//
//+ (id) readStreamSink:(FLReadStream*) readStream {
//    return FLAutorelease([[[self class] alloc] initWithReadStream:readStream]);
//}

//- (void) removeFromStream {
//    [self.networkStream removeListener:self];
//    self.networkStream = nil;
//}
//
//- (void) attachToStream:(FLReadStream*) stream {
//    [self removeFromStream];
//    self.networkStream = stream;
//    [self.networkStream addListener:self];
//}

//- (void) dealloc {
//    [_readStream removeListener:self];
//    
//#if FL_MRC
//    [_readStream release];
//    [super dealloc];
//#endif
//}

- (void) appendBytes:(const void *)bytes length:(NSUInteger)length {
}

- (void) readBytesFromStream:(FLReadStream*) stream 
                  withBuffer:(uint8_t*) buffer 
                  bufferSize:(NSUInteger) bufferSize {

    while(stream.hasBytesAvailable && !stream.error) {
        NSUInteger bytesRead = [stream readBytes:buffer maxLength:bufferSize];
        if(bytesRead) {
            [self appendBytes:buffer length:bytesRead];
        }
    }
}                  

- (NSData*) data {
    return nil;
}

- (NSURL*) fileURL {
    return nil;
}





@end

@interface FLDataStreamSink ()
@property (readwrite, strong, nonatomic) NSData* data;
@property (readwrite, strong, nonatomic) NSMutableData* responseData;
@end

@implementation FLDataStreamSink

@synthesize data = _data;
@synthesize responseData = _responseData;

+ (id) dataStreamSink {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) networkStreamWillOpen:(FLNetworkStream *)networkStream {
    self.responseData = [NSMutableData data];
    self.data = nil;
}

- (void) appendBytes:(const void *)bytes length:(NSUInteger)length {
    [self.responseData appendBytes:bytes length:length];
}

#if FL_MRC
- (void) dealloc {
    [_responseData release];
    [_data release];
    [super dealloc];
}
#endif

#define kBufferSize 1024

- (void) networkStreamHasBytesAvailable:(FLReadStream *)networkStream {
    uint8_t buffer[kBufferSize];
    [self readBytesFromStream:networkStream withBuffer:buffer bufferSize:kBufferSize];
}

- (void) networkStreamDidClose:(FLNetworkStream *)networkStream {
    if(networkStream.error) {
        self.data = nil;
        self.responseData = nil;
    }
    else {
        self.data = self.responseData;
        self.responseData = nil;
    }
}

//- (NSInputStream*) readStream {
//    FLConfirm_v(_responseData == nil, @"can't get data from an open receiver");
//    return [NSInputStream inputStreamWithData:self.data];
//}

- (NSURL*) fileURL {
    return nil;
}
@end

@interface FLFileStreamSink ()
@property (readwrite, strong, nonatomic) NSOutputStream* outputStream;
@property (readwrite, strong, nonatomic) NSURL* fileURL;
@end

@implementation FLFileStreamSink

@synthesize outputStream = _outputStream;
@synthesize fileURL = _fileURL;

- (id) initWithFileURL:(NSURL*) fileURL {
    self = [super init];
    if(self) {
        self.fileURL = fileURL;
    }
    return self;
}

+ (id) fileStreamSink:(NSURL*) fileURL {
    return FLAutorelease([[[self class] alloc] initWithFileURL:fileURL]);
}

- (void) networkStreamWillOpen:(FLNetworkStream *)networkStream {
    self.outputStream = [NSOutputStream outputStreamWithURL:self.fileURL append:NO];
    [self.outputStream open];
}

- (void) appendBytes:(const void *)bytes length:(NSUInteger)length {
    NSInteger amountWritten = [self.outputStream write:bytes maxLength:length];
    FLAssert_(amountWritten == length);
}

- (void) networkStreamHasBytesAvailable:(FLReadStream *)networkStream {
    [self readBytesFromStream:networkStream withBuffer:_bufferHunk bufferSize:FLFileResponseReceiverFileBufferSize];
}

- (void) networkStreamDidClose:(FLNetworkStream *)networkStream {

    [self.outputStream close];
    self.outputStream = nil;
    
    if(networkStream.error) {
        NSError* fileError = nil;
        [[NSFileManager defaultManager] removeItemAtURL:self.fileURL error:&fileError];

// todo: do what with error?

//        return FLAutorelease(fileError);
    }
    
}

#if FL_MRC
- (void) dealloc {
    [_fileURL release];
    [_outputStream release];
    [super dealloc];
}
#endif

- (NSData*) data {
    FLConfirm_v(_outputStream == nil, @"can't get data from an open receiver");
    
    NSError* error = nil;
    NSData* data = [NSData dataWithContentsOfURL:self.fileURL options:nil error:&error];
    FLThrowIfError(error);
    
    return data;
}

//- (NSInputStream*) readStream {
//    FLConfirm_v(_outputStream == nil, @"can't get data from an open receiver");
//    return [NSInputStream inputStreamWithURL:self.fileURL];
//}
@end
//
//  FLResponseReceiver.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/4/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLResponseReceiver.h"
#import "FLReadStream.h"

//- (NSInteger) readBytesIntoBuffer:(uint8_t*) buffer 
//                       bufferSize:(NSUInteger) bufferSize
//                         receiver:(id) receiver {
//
//    unsigned long bytesRead = 0;
//    while([self hasBytesAvailable]) {
//        bytesRead = CFReadStreamRead(self.streamRef, buffer, bufferSize);
//        if([self readResultIsError:bytesRead]) {
//            break;
//        }
//
//        [receiver appendBytes:buffer length:bytesRead];
//    }
//    
//    if(bytesRead > 0) {
//        [self.delegate readStream:self didReadBytes:bytesRead];
//    }
//
//    return bytesRead;
//}                                                                       
//    
//#define kBufferSize 1024 
//
//- (NSInteger) readAvailableBytes:(NSMutableData*) data {
//    FLAssertNotNil_(_streamRef);
//    uint8_t buffer[kBufferSize];
//    return [self readBytesIntoBuffer:buffer bufferSize:kBufferSize receiver:data]
//}                                          

@implementation FLResponseReceiver 

- (NSData*) data {
    return nil;
}

- (NSInputStream*) readStream {
    return nil;
}

- (NSURL*) fileURL {
    return nil;
}


- (void) appendBytes:(const void *)bytes length:(NSUInteger)length {
}

- (void) readBytesFromStream:(FLReadStream*) stream 
                  withBuffer:(uint8_t*) buffer 
                  bufferSize:(NSUInteger) bufferSize {

    while([stream hasBytesAvailable]) {
        NSUInteger bytesRead = [stream readBytes:buffer maxLength:bufferSize];
        if(bytesRead) {
            [self appendBytes:buffer length:bytesRead];
        }
    }
                  
}                  

- (void) readBytesFromStream:(FLReadStream*) stream {
}

- (NSError*) closeWithResult:(id) result {
    return nil;
}

@end


@interface FLDataResponseReceiver ()
@property (readwrite, strong, nonatomic) NSData* data;
@property (readwrite, strong, nonatomic) NSMutableData* responseData;
@end

@implementation FLDataResponseReceiver

@synthesize data = _data;
@synthesize responseData = _responseData;

+ (id) dataResponseReceiver {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) appendBytes:(const void *)bytes length:(NSUInteger)length {
    if(!_responseData) {
        _responseData = [[NSMutableData alloc] init];
        self.data = nil;
    }
    [_responseData appendBytes:bytes length:length];
}

#if FL_MRC
- (void) dealloc {
    [_responseData release];
    [_data release];
    [super dealloc];
}
#endif

#define kBufferSize 1024
- (void) readBytesFromStream:(FLReadStream*) stream {
    uint8_t buffer[kBufferSize];
    [self readBytesFromStream:stream withBuffer:buffer bufferSize:kBufferSize];
}

- (NSError*) closeWithResult:(id) result {
    if([result error]) {
        self.data = nil;
        self.responseData = nil;
    }
    else {
        self.data = self.responseData;
        self.responseData = nil;
    }
    
    return nil;
}

- (NSInputStream*) readStream {
    FLConfirm_v(_responseData == nil, @"can't get data from an open receiver");
    return [NSInputStream inputStreamWithData:self.data];
}

- (NSURL*) fileURL {
    return nil;
}
@end

@interface FLFileResponseReceiver ()
@property (readwrite, strong, nonatomic) NSOutputStream* outputStream;
@property (readwrite, strong, nonatomic) NSURL* fileURL;
@end

@implementation FLFileResponseReceiver

@synthesize outputStream = _outputStream;
@synthesize fileURL = _fileURL;

- (id) initWithFileURL:(NSURL*) fileURL {
    self = [super init];
    if(self) {
        self.fileURL = fileURL;
    }
    return self;
}

+ (id) fileResponseReceiver:(NSURL*) fileURL {
    return FLAutorelease([[[self class] alloc] initWithFileURL:fileURL]);
}

- (void) open {
    self.outputStream = [NSOutputStream outputStreamWithURL:self.fileURL append:NO];
    [self.outputStream open];
}

- (void) appendBytes:(const void *)bytes length:(NSUInteger)length {
   
    if(!_outputStream) {
        [self open];
    }
     
    NSInteger amountWritten = [self.outputStream write:bytes maxLength:length];
    FLAssert_(amountWritten == length);
    
}

- (void) readBytesFromStream:(FLReadStream*) stream {
    [self readBytesFromStream:stream withBuffer:_bufferHunk bufferSize:FLFileResponseReceiverFileBufferSize];
}

- (NSError*) closeWithResult:(id) result {
    [self.outputStream close];
    self.outputStream = nil;
    
    if([result error]) {
        NSError* error = nil;
        [[NSFileManager defaultManager] removeItemAtURL:self.fileURL error:&error];
        return FLAutorelease(error);
    }
    
    return nil;
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

- (NSInputStream*) readStream {
    FLConfirm_v(_outputStream == nil, @"can't get data from an open receiver");
    return [NSInputStream inputStreamWithURL:self.fileURL];
}
@end
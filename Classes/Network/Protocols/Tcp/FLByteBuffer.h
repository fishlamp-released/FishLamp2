//
//  FLTcpByteReader.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FLByteBufferDeadBeafSize 4

@interface FLByteBuffer : NSObject {
@private
    NSUInteger _contentLength;
}

+ (FLByteBuffer*) byteBuffer;

@property (readonly, nonatomic, assign) NSUInteger capacity;

@property (readonly, nonatomic, assign) uint8_t* content;
@property (readonly, nonatomic, assign) NSUInteger length;

@property (readonly, nonatomic, assign) uint8_t* unusedContent;
@property (readonly, nonatomic, assign) NSUInteger unusedContentLength;

@property (readonly, nonatomic, assign) BOOL isFull;

- (void) incrementContentLength:(NSUInteger) byAmount;

- (NSData*) copyToData;

- (void) clear;

- (NSUInteger) appendBytes:(const void*) bytes length:(NSUInteger) length;

- (NSUInteger) appendData:(NSData*) data;

- (BOOL) checkDeadBeaf;

@end

@interface FLAllocatedByteBuffer : FLByteBuffer {
@private
    NSUInteger _capacity;
    void* _buffer;
}

- (id) initWithCapacity:(NSUInteger) expectedSize;

+ (FLByteBuffer*) byteBuffer:(NSUInteger) capacity;

@end


#define FLDeclareFixedSizedBuffer(__SIZE__) \
            @interface FLByteBuffer##__SIZE__ : FLByteBuffer { \
                uint8_t _buffer[__SIZE__ + FLByteBufferDeadBeafSize]; \
            } \
            @end
            
#define FLSynthesizeFixedSizedBuffer(__SIZE__) \
            @implementation FLByteBuffer##__SIZE__ \
            - (uint8_t*) content { \
                return (uint8_t*) _buffer; \
            } \
            - (NSUInteger) bufferLength { \
                return __SIZE__; \
            } \
            @end


FLDeclareFixedSizedBuffer(128);
FLDeclareFixedSizedBuffer(256);
FLDeclareFixedSizedBuffer(512);
FLDeclareFixedSizedBuffer(1024);

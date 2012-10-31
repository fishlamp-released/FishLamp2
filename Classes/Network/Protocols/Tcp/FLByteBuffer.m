//
//  FLTcpByteReader.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLByteBuffer.h"

#define FLAssertDeadBeaf_v() \
            FLAssert_v((*_deadBeafPtr) == 0xDEADBEAF, @"buffer overrun detected");

@implementation FLByteBuffer

@synthesize length = _contentLength;

- (id) init {
    self = [super init];
    if(self) {

#if DEBUG
        _deadBeafPtr = ((uint32_t*)(self.content + self.capacity));
        *(_deadBeafPtr) = 0xDEADBEAF;
#endif        
       
       _contentLength = 0;
    }
    
    return self;
}

+ (FLByteBuffer*) byteBuffer {
    return autorelease_([[[self class] alloc] init]);
}

- (BOOL) isFull {
    return self.capacity == _contentLength;
}

- (uint8_t*) unusedContent {
    return self.content + _contentLength;
}

- (NSUInteger) unusedContentLength {
    return self.capacity - _contentLength;
}

- (void) incrementContentLength:(NSUInteger) byAmount {
    FLAssertDeadBeaf_v();
    _contentLength += byAmount;
    FLConfirm_v(_contentLength < self.capacity, @"buffer overrun");
}

- (uint8_t*) content {
    return nil;
}

- (NSUInteger) capacity {
    return 0;
}

- (void) clear {
    _contentLength = 0;
}

- (NSData*) copyToData {
    return [[NSData alloc] initWithBytes:self.content length:self.length];
}

- (NSUInteger) appendBytes:(const void*) bytes length:(NSUInteger) length {
    NSUInteger amount = MIN(length, self.unusedContentLength);
    if(amount) {
        memcpy((void*) self.unusedContent, (void*) bytes, amount);
        _contentLength += amount;
    }
    
    FLAssertDeadBeaf_v();
    return amount;
}

- (NSUInteger) appendData:(NSData*) data {
    return [self appendBytes:data.bytes length:data.length];
}
@end


@implementation FLAllocatedByteBuffer

FLAssertDefaultInitNotCalled_();

- (id) initWithCapacity:(NSUInteger) capacity {
    self = [super init];
    if(self) {
        _capacity = capacity + FLByteBufferDeadBeafSize;
        _buffer = malloc(capacity);
    }
    
    return self;
}

- (uint8_t*) content {
    return _buffer;
}

- (NSUInteger) capacity {
    return _capacity;
}

+ (FLByteBuffer*) byteBuffer:(NSUInteger) length {
    return autorelease_([[FLAllocatedByteBuffer alloc] initWithCapacity:length]);
}

- (void) dealloc {
    if(_buffer) {
        free(_buffer);
        _buffer = nil;
    }
    mrc_super_dealloc_();
}

@end

FLSynthesizeFixedSizedBuffer(128);
FLSynthesizeFixedSizedBuffer(256);
FLSynthesizeFixedSizedBuffer(512);
FLSynthesizeFixedSizedBuffer(1024);
//
//  FLByteBufferTests.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/5/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLByteBufferTests.h"
#import "FLByteBuffer.h"

FLDeclareFixedSizedBuffer(2)
FLSynthesizeFixedSizedBuffer(2)



@implementation FLByteBufferTests

+ (FLUnitTestGroup*) unitTestGroup {
    return [self frameworkTestGroup];
}

- (void) testSimpleCopy {
    
    FLByteBuffer* buffer = [FLByteBuffer128 byteBuffer];
    
    const char* str = "hello world";

    [buffer appendBytes:str length:strlen(str)];
    
    FLAssertAreEqual(buffer.length, strlen(str));
    
    FLAssertWithComment(strncmp(str, (char*)buffer.content, strlen(str)) == 0, @"buffer write failed");
    
}

- (void) testTooSmall {
    
    FLByteBuffer* buffer = [FLByteBuffer2 byteBuffer];
    
    const char* str = "hello world";

    [buffer appendBytes:str length:strlen(str)];
    FLAssertAreEqual(buffer.length, 2);
    
    FLAssertWithComment(strncmp(str, (char*)buffer.content, 2) == 0,@"buffer write failed");
    
}




@end

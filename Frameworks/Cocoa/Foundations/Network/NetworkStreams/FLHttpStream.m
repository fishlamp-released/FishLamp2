//
//  FLHttpStream.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLHttpStream.h"

#import "FLHttpMessage.h"

@implementation FLHttpStream

- (FLHttpMessage*) readResponseHeaders {
    
    CFHTTPMessageRef ref = (CFHTTPMessageRef)CFReadStreamCopyProperty(self.streamRef, kCFStreamPropertyHTTPResponseHeader);
    @try {
        return [FLHttpMessage httpMessageWithHttpMessageRef:ref];
    }
    @finally {
        if(ref) {
            CFRelease(ref);
        }
    }
}

- (unsigned long) bytesWritten {
    NSNumber* number = FLAutorelease(bridge_transfer_(NSNumber*,
        CFReadStreamCopyProperty(self.streamRef, kCFStreamPropertyHTTPRequestBytesWrittenCount)));
    
    return number.unsignedLongValue;
}

- (id) initWithURL:(NSURL*) url
        httpMethod:(NSString*) httpMethod
           headers:(NSDictionary*) headers
          bodyData:(NSData*) bodyData {

    self = [super init];
    if(self) {
        FLHttpMessage* message = [FLHttpMessage httpMessageWithURL:url httpMethod:httpMethod];
        message.headers = headers;
        message.bodyData = bodyData;
    
        CFReadStreamRef readStreamRef = CFReadStreamCreateForHTTPRequest(kCFAllocatorDefault, message.messageRef);
        self.streamRef = readStreamRef;
        CFRelease(readStreamRef);
        
        FLConfirmNotNil_v(readStreamRef, @"unable to create CFReadStreamRef");
    }
    
    return self;
}                     

- (id) initWithURL:(NSURL*) url
        httpMethod:(NSString*) httpMethod
           headers:(NSDictionary*) headers
        bodyStream:(NSInputStream*) bodyStream  {

    self = [super init];
    if(self) {
        FLHttpMessage* message = [FLHttpMessage httpMessageWithURL:url 
                                                        httpMethod:httpMethod];
        message.headers = headers;
        
        CFReadStreamRef readStreamRef = CFReadStreamCreateForStreamedHTTPRequest(kCFAllocatorDefault, message.messageRef, bridge_(CFReadStreamRef, bodyStream));
        self.streamRef = readStreamRef;
        CFRelease(readStreamRef);
        
        FLConfirmNotNil_v(readStreamRef, @"unable to create CFReadStreamRef");
    }
    
    return self;
}      

- (id) initWithHeaders:(FLHttpRequestHeaders*) headers withBodyStream:(NSInputStream*) inputStream {
    return [self initWithURL:headers.requestURL httpMethod:headers.httpMethod headers:headers.allHeaders bodyStream:inputStream];
}             

- (id) initWithHeaders:(FLHttpRequestHeaders*) headers withBodyData:(NSData*) bodyData {
    return [self initWithURL:headers.requestURL httpMethod:headers.httpMethod headers:headers.allHeaders bodyData:bodyData];
}             

+ (id) httpStream:(NSURL*) url
                   httpMethod:(NSString*) method
                      headers:(NSDictionary*) headers
                     bodyData:(NSData*) bodyData {
    return FLAutorelease([[[self class] alloc] initWithURL:url httpMethod:method headers:headers bodyData:bodyData]);
}

+ (id) httpStream:(NSURL*) url
                   httpMethod:(NSString*) method
                      headers:(NSDictionary*) headers
                   bodyStream:(NSInputStream*) bodyStream {
    return FLAutorelease([[[self class] alloc] initWithURL:url httpMethod:method headers:headers bodyStream:bodyStream]);
}

+ (id) httpStream:(FLHttpRequestHeaders*) headers withBodyStream:(NSInputStream*) inputStream {
    return FLAutorelease([[[self class] alloc] initWithHeaders:headers withBodyStream:inputStream]);
}

+ (id) httpStream:(FLHttpRequestHeaders*) headers withBodyData:(NSData*) bodyData {
    return FLAutorelease([[[self class] alloc] initWithHeaders:headers withBodyData:bodyData]);
}

@end






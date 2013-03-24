//
//  FLHttpStream.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLHttpStream.h"

@implementation FLHttpStream
@synthesize responseHeaders = _responseHeaders;
@synthesize requestHeaders = _requestHeaders;

- (id) initWithHttpMessage:(FLHttpMessage*) request {
    self = [super init];
    if(self ) {
        _requestHeaders = FLRetain(request);
    }
    return self;
}

- (id) initWithHttpMessage:(FLHttpMessage*) request withBodyStream:(NSInputStream*) bodyStream {
    self = [super init];
    if(self ) {
        _requestHeaders = FLRetain(request);
        _bodyStream = FLRetain(bodyStream);
    }
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_requestHeaders release];
    [_bodyStream release];
    [_responseHeaders release];
    [super dealloc];
}
#endif

- (void) willOpen {
    FLReleaseWithNil(_responseHeaders);
    [super willOpen];
}

- (CFReadStreamRef) createReadStreamRef {
    if(_bodyStream) {
        return CFReadStreamCreateForStreamedHTTPRequest(kCFAllocatorDefault, _requestHeaders.messageRef, bridge_(CFReadStreamRef, _bodyStream));
    }
    
    return CFReadStreamCreateForHTTPRequest(kCFAllocatorDefault, _requestHeaders.messageRef);
}

+ (id) httpStream:(FLHttpMessage*) request {
    return FLAutorelease([[[self class] alloc] initWithHttpMessage:request]);
}

+ (id) httpStream:(FLHttpMessage*) request 
            withBodyStream:(NSInputStream*) bodyStream {
    return FLAutorelease([[[self class] alloc] initWithHttpMessage:request withBodyStream:bodyStream]);
}            

- (BOOL) hasResponseHeaders {
    return _responseHeaders != nil;
}

- (void) openIfNeeded {
    if(!_responseHeaders) {
        CFHTTPMessageRef ref = (CFHTTPMessageRef)CFReadStreamCopyProperty(self.streamRef, kCFStreamPropertyHTTPResponseHeader);
        @try {
            if(CFHTTPMessageIsHeaderComplete(ref)) {
                _responseHeaders = [[FLHttpMessage alloc] initWithHttpMessageRef:ref];
                [self didOpen];
            }
        }
        @finally {
            if(ref) {
                CFRelease(ref);
            }
        }
    }
}

- (void) encounteredError:(NSError*) error {
    [self openIfNeeded];
    [super encounteredError:error];
}

- (void) encounteredEnd {
    [self openIfNeeded];
    [super encounteredEnd];
}

- (void) encounteredBytesAvailable {
    [self openIfNeeded];
    [super encounteredBytesAvailable];
}

- (unsigned long) bytesWritten {
    NSNumber* number = FLAutorelease(bridge_transfer_(NSNumber*,
        CFReadStreamCopyProperty(self.streamRef, kCFStreamPropertyHTTPRequestBytesWrittenCount)));
    
    return number.unsignedLongValue;
}

@end






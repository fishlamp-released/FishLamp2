//
//  FLTcpStream.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLTcpStream.h"

@interface FLTcpStream ()
@property (readwrite, assign, nonatomic) int32_t remotePort;
@property (readwrite, strong) NSString* remoteHost;
@property (readwrite, strong) FLReadStream* readStream;
@property (readwrite, strong) FLWriteStream* writeStream;
@end

@implementation FLTcpStream
@synthesize remotePort = _remotePort;
@synthesize remoteHost = _remoteHost;
@synthesize readStream = _readStream;
@synthesize writeStream = _writeStream;

- (id) initWithRemoteHost:(NSString*) remoteHost remotePort:(int32_t) remotePort {
    self = [self init];
    if(self) {
        self.remoteHost = remoteHost;
        self.remotePort = remotePort;
    }
    
    return self;
}

+ (id) tcpStream:(NSString*) remoteHost  remotePort:(int32_t) remotePort {
    return autorelease_([[[self class] alloc] initWithRemoteHost:remoteHost remotePort:remotePort]);
}

- (void) openSelf {

    FLAssertIsNil_(self.readStream);
    FLAssertIsNil_(self.writeStream);

    CFReadStreamRef readStream = nil;
    CFWriteStreamRef writeStream = nil;
    CFHostRef host = nil;
    
    @try {
        FLAssert_v(self.remotePort != 0, @"remote port can't be zero");
        FLAssertStringIsNotEmpty_(self.remoteHost);
       
        host = CFHostCreateWithName(NULL, bridge_(void*,self.remoteHost));
        if(!host) {
            FLThrowError_([NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorCannotFindHost localizedDescription:@"Unable to find to host"]);
        }
        
        CFStreamCreatePairWithSocketToCFHost(NULL, host, self.remotePort, &readStream, &writeStream);
        if(!readStream || !writeStream) {
            FLThrowError_([NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorNetworkConnectionLost localizedDescription:@"Unable to connect to host"]);
        }
                
        self.readStream = [FLReadStream readStream:readStream];
        self.readStream.delegate = self;
        self.writeStream = [FLWriteStream writeStream:writeStream];
        self.writeStream.delegate = self;
        
        [self.readStream openStream];
        [self.writeStream openStream];
    }
    @finally {
        if(host) {
            CFRelease(host);
        }
        if(readStream) {
            CFRelease(readStream);
        }
        if(writeStream) {
            CFRelease(writeStream);
        }
    }
}

- (void) dealloc {
    self.delegate = nil;

    FLAssert_(!self.isOpen);
    
#if FL_MRC
    [_remoteHost release];
    [_writeStream release];
    [_readStream release];
    [super dealloc];
#endif
}

- (void) closeSelf {
    if(_readStream) {
        _readStream.delegate = nil;
        [_readStream closeStream];
        self.readStream = nil;
    }
    if(_writeStream) {
        _writeStream.delegate = nil;
        [_writeStream closeStream];
        self.writeStream = nil;
    }
}

- (NSError*) error {
    NSError* error = self.writeStream.error;
    if(!error) {
        error = self.readStream.error;
    }

    return error;
}

- (void) networkStreamDidClose:(id<FLNetworkStream>) networkStream withResult:(id<FLResult>) result {
    [self closeStream];
}

- (void) networkStreamDidOpen:(id<FLNetworkStream>) networkStream {
    if(self.isOpen) {
        FLPerformSelectorWithObject(self.delegate, @selector(networkStreamDidOpen:), self);
    }
}

- (void) readStreamHasBytesAvailable:(id<FLNetworkStream>) networkStream {
    FLPerformSelectorWithObject(self.delegate, @selector(readStreamHasBytesAvailable:), self);
}


- (void) writeStreamCanAcceptBytes:(id<FLNetworkStream>) networkStream {
    FLPerformSelectorWithObject(self.delegate, @selector(writeStreamCanAcceptBytes:), self);
    
}

- (void) writeStreamDidWriteBytes:(id<FLNetworkStream>) stream {
    FLPerformSelectorWithObject(self.delegate, @selector(writeStreamDidWriteBytes:), self);
    
}

- (void) readStreamDidReadBytes:(id<FLNetworkStream>) stream{
    FLPerformSelectorWithObject(self.delegate, @selector(readStreamDidReadBytes:), self);
    
}

- (BOOL) isOpen {
    return self.writeStream.isOpen && self.readStream.isOpen;
}

@end

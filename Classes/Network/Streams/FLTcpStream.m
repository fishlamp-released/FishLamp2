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

- (void) openStream {

    FLAssertIsNil_(self.readStream);
    FLAssertIsNil_(self.writeStream);

    CFReadStreamRef readStream = nil;
    CFWriteStreamRef writeStream = nil;
   
    FLAssert_v(self.remotePort != 0, @"remote port can't be zero");
    FLAssertStringIsNotEmpty_(self.remoteHost);
   
    CFHostRef host = CFHostCreateWithName(NULL, bridge_(void*,self.remoteHost));
    if (host != NULL)  {
        CFStreamCreatePairWithSocketToCFHost(NULL, host, self.remotePort, &readStream, &writeStream);
        
        if(readStream && writeStream) {
            self.readStream = [FLReadStream readStream:readStream];
            self.readStream.delegate = self;
            self.writeStream = [FLWriteStream writeStream:writeStream];
            self.writeStream.delegate = self;
            
            [self.readStream openStream];
            [self.writeStream openStream];
            
            [super openStream];
        }
        else {
            [self closeStream];
            [self.delegate performIfRespondsToSelector:@selector(networkStreamDidClose:) withObject:self];
        }

        CFRelease(host);
        host = nil;
    }

    if(readStream) {
        CFRelease(readStream);
    }
    if(writeStream) {
        CFRelease(writeStream);
    }
}

- (void) dealloc {
    self.delegate = nil;
    [self closeStream];

#if FL_MRC
    [_remoteHost release];
    [_writeStream release];
    [_readStream release];
    [super dealloc];
#endif
}

- (BOOL) isRunning {
    return self.writeStream.isRunning && self.readStream.isRunning;
}

- (void) closeStream {
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
    [super closeStream];
}

- (NSError*) error {
    NSError* error = self.writeStream.error;
    if(!error) {
        error = self.readStream.error;
    }

    return error;
}

- (void) networkStreamDidClose:(id<FLNetworkStream>) networkStream {
    [self closeStream];
    [self.delegate performIfRespondsToSelector:@selector(networkStreamDidClose:) withObject:self];
}

- (void) networkStreamDidOpen:(id<FLNetworkStream>) networkStream {
    if(self.isOpen) {
        [self.delegate performIfRespondsToSelector:@selector(networkStreamDidOpen:) withObject:self];
    }
}

- (void) readStreamHasBytesAvailable:(id<FLNetworkStream>) networkStream {
    [self.delegate performIfRespondsToSelector:@selector(readStreamHasBytesAvailable:) withObject:self];
}

- (void) networkStreamEncounteredError:(id<FLNetworkStream>) networkStream {
    [self.delegate performIfRespondsToSelector:@selector(networkStreamEncounteredError:) withObject:self];
    
}

- (void) writeStreamCanAcceptBytes:(id<FLNetworkStream>) networkStream {
    [self.delegate performIfRespondsToSelector:@selector(writeStreamCanAcceptBytes:) withObject:self];
    
}

- (void) writeStreamDidWriteBytes:(id<FLNetworkStream>) stream {
    [self.delegate performIfRespondsToSelector:@selector(writeStreamDidWriteBytes:) withObject:self];
    
}

- (void) readStreamDidReadBytes:(id<FLNetworkStream>) stream{
    [self.delegate performIfRespondsToSelector:@selector(readStreamDidReadBytes:) withObject:self];
    
}

- (BOOL) isOpen {
    return self.writeStream.isOpen && self.readStream.isOpen;
}

@end

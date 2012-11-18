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
        
        [self.readStream openStream:nil];
        [self.writeStream openStream:nil];
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

- (void) closeSelf:(NSError*) error {
    if(_readStream) {
        _readStream.delegate = nil;
        [_readStream closeStream:error];
        self.readStream = nil;
    }
    if(_writeStream) {
        _writeStream.delegate = nil;
        [_writeStream closeStream:error];
        self.writeStream = nil;
    }
}

- (NSError*) error {
    return [NSError tcpStreamError:[self.readStream error] writeError:[self.writeStream error]];
}

- (void) networkStreamDidClose:(id<FLNetworkStream>) networkStream withError:(NSError*) error {
    [self closeStream:error ];
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

NSString* const FLTcpStreamWriteErrorKey = @"FLTcpStreamWriteErrorKey";
NSString* const FLTcpStreamReadErrorKey = @"FLTcpStreamReadErrorKey";

@interface FLTcpStreamError : NSError
@end

@implementation NSError (FLTcpStream)

- (NSError*) readError {
    return self;
}

- (NSError*) writeError {
    return self;
}

+ (NSError*) tcpStreamError:(NSError*) readError writeError:(NSError*) writeError {
    if(readError && writeError) {
// this seems unlikely to happen  - but just in case.    
        NSMutableDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:
                                     readError, FLTcpStreamReadErrorKey, 
                                     writeError, FLTcpStreamWriteErrorKey,
                                     [NSString stringWithFormat:@"readError: %@, writeError %@", [readError localizedDescription], [writeError localizedDescription]], NSLocalizedDescriptionKey, 
                                     nil];
    
        return [FLTcpStreamError errorWithDomain:FLFrameworkErrorDomainName code:FLFrameworkTcpStreamErrorCode userInfo:dict];
    }
    if(readError) {
        return readError;
    }
    if(writeError) {
        return writeError;
    }
    
    return nil;
}

@end

@implementation FLTcpStreamError

- (NSString*) description {
    return [NSString stringWithFormat:@"%@ { readError: %@, writeError: %@ }",[super description], [self.readError description], [self.writeError description]];
}

- (NSError*) readError {
    return [self.userInfo objectForKey:FLTcpStreamReadErrorKey];
}

- (NSError*) writeError {
    return [self.userInfo objectForKey:FLTcpStreamWriteErrorKey];
}

@end



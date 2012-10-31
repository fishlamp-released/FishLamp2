//
//  FLNetworkHostResolver.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLNetworkHostResolver.h"
#import "FLNetworkStream.h"

@interface FLNetworkHostResolver ()
@property (readwrite, retain, nonatomic) FLNetworkHost* networkHost;
@end

@interface FLNetworkHostResolverStream : NSObject<FLNetworkStream> {
@private
    __unsafe_unretained id _delegate;
    BOOL _connecting;
}
@property (readwrite, assign) BOOL isOpen;
@end

@implementation FLNetworkHostResolver

@synthesize networkHost = _networkHost;

- (id) initWithNetworkHost:(FLNetworkHost*) host {
    self = [super init];
    if(self) {
        self.networkHost = host;
    }
    return self;
}

+ (FLNetworkHostResolver*) networkHostResolver:(FLNetworkHost*) host {
    return FLReturnAutoreleased([[FLNetworkHostResolver alloc] initWithNetworkHost:host]);
}

- (id<FLNetworkStream>) createNetworkStream {
    return [FLNetworkHostResolverStream create];
}

#if FL_MRC
- (void) dealloc {
    FLRelease(_networkHost);
    FLSuperDealloc();
}
#endif

@end


@implementation FLNetworkHostResolverStream

@synthesize delegate = _delegate;
@synthesize isOpen = _connecting;

- (FLNetworkHost*) networkHost {
    return [self.delegate networkHost];
}

- (BOOL) isRunning {
    return _connecting;
}

- (id) output {
    return self.networkHost;
}
- (void) resolutionCallback:(CFHostRef) theHost
                   typeInfo:(CFHostInfoType) typeInfo
                      error:(const CFStreamError*) error {

    FLAssertAreEqual_v(self.networkHost.hostRef, theHost, nil);
    FLAssertAreEqual_v(self.networkHost.hostInfoType, typeInfo, nil);
    
    if ( (error == NULL) || ( (error->domain == 0) && (error->error == 0) ) ) {
        self.networkHost.resolved = YES;
        [self.delegate performIfRespondsToSelector:@selector(networkStreamDidClose:) withObject:self];
    }
    else {
        [self.delegate performIfRespondsToSelector:@selector(networkStreamEncounteredError:) withObject:self];
    }
}

static void HostResolutionCallback(CFHostRef theHost, CFHostInfoType typeInfo, const CFStreamError *error, void *info) {
    FLNetworkHostResolverStream* resolver = FLBridgeToObject(info);
    FLCAssertIsKindOfClass_v(resolver, FLNetworkHostResolverStream, nil);
    [resolver resolutionCallback:theHost typeInfo:typeInfo error:error];
}


- (NSError*) error {
// FIXME
    return nil;
}

- (void) openStream {
    
    CFHostClientContext context = { 0, FLBridge(void*, self), NULL, NULL, NULL };
    CFStreamError       streamError = { 0, 0 };
    NSError *           error = nil;

    CFHostRef host = self.networkHost.hostRef;
    FLAssertIsNotNil_v(host, nil);

    BOOL success = CFHostSetClient(host, HostResolutionCallback, &context);
    if ( ! success ) {
        error = [NSError errorWithDomain:NSPOSIXErrorDomain code:EINVAL userInfo:nil];
    }

    if (error == nil) {
        self.isOpen = YES;

        CFHostScheduleWithRunLoop(host, CFRunLoopGetCurrent(), FLBridgeToCFRef(kRunLoopMode));
        success = CFHostStartInfoResolution(host, self.networkHost.hostInfoType, &streamError);
        if ( ! success ) {
            error = [FLNetworkConnection errorFromStreamError:streamError];
        }
    }
    
    if(error) {
        [self.delegate performIfRespondsToSelector:@selector(networkStreamEncounteredError:) withObject:self];
    }
    else {
        [self.delegate performIfRespondsToSelector:@selector(networkStreamDidOpen:) withObject:self];
    }
}

- (void) closeStream {
    CFHostRef host = self.networkHost.hostRef;
    if(self.isOpen && host) {
        /*BOOL success = */ CFHostSetClient(host, NULL, NULL);
        CFHostUnscheduleFromRunLoop(host, CFRunLoopGetCurrent(), FLBridgeToCFRef(kRunLoopMode));
        CFHostCancelInfoResolution(host, self.networkHost.hostInfoType);
    }
    self.isOpen = NO;
}

- (id<FLReadStream>) readStream {
    return nil;
}

- (id<FLWriteStream>) writeStream {
    return nil;
}


@end

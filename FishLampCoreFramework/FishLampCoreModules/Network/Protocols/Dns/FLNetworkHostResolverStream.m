//
//  FLNetworkHostResolverStream.m
//  FishLampCore
//
//  Created by Mike Fullerton on 11/10/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLNetworkHostResolverStream.h"
#import "FLNetworkHost.h"
#import "NSError+FLNetworkStream.h"
#import "FLNetworkStream.h"

@interface FLNetworkHostResolverStream ()
@property (readwrite, strong) FLNetworkHost* networkHost;
@end

@implementation FLNetworkHostResolverStream

synthesize_(error)
synthesize_(networkHost);

- (id) initWithNetworkHost:(FLNetworkHost*) networkHost {
    self = [super init];
    if(self) {
        self.networkHost = networkHost;
    }
    
    return self;
}

- (void) resolutionCallback:(CFHostRef) theHost
                   typeInfo:(CFHostInfoType) typeInfo
                      error:(const CFStreamError*) error {

    FLAssertAreEqual_v(self.networkHost.hostRef, theHost, nil);
    FLAssertAreEqual_v(self.networkHost.hostInfoType, typeInfo, nil);
    
    self.error = FLCreateErrorFromStreamError(error);
    
    if (!self.error) {
        self.networkHost.resolved = YES;
    }
    
    [self closeStream:self.error];
}

static void HostResolutionCallback(CFHostRef theHost, CFHostInfoType typeInfo, const CFStreamError *error, void *info) {
    FLNetworkHostResolverStream* resolver = bridge_(id, info);
    FLAssertIsKindOfClass_v(resolver, FLNetworkHostResolverStream, nil);
    [resolver resolutionCallback:theHost typeInfo:typeInfo error:error];
}

- (void) openNetworkStream {
    
    CFHostClientContext context = { 0, bridge_(void*, self), NULL, NULL, NULL };
  
    CFHostRef host = self.networkHost.hostRef;
    FLAssertIsNotNil_v(host, nil);

    @try {
        if (!CFHostSetClient(host, HostResolutionCallback, &context)) {
            FLThrowError_([NSError errorWithDomain:NSPOSIXErrorDomain code:EINVAL userInfo:nil]);
        }

        CFHostScheduleWithRunLoop(host, CFRunLoopGetCurrent(), bridge_(void*,NSDefaultRunLoopMode));
        CFStreamError streamError = { 0, 0 };
        if (!CFHostStartInfoResolution(host, self.networkHost.hostInfoType, &streamError) ) {
            FLThrowError_(FLCreateErrorFromStreamError(&streamError));
        }
    }
    @catch(NSException* ex) {
        self.error = ex.error;
        @throw;
    }
}

- (void) closeNetworkStream {
    CFHostRef host = self.networkHost.hostRef;
    if(host) {
        /*BOOL success = */ CFHostSetClient(host, NULL, NULL);
        CFHostUnscheduleFromRunLoop(host, CFRunLoopGetCurrent(), bridge_(void*,NSDefaultRunLoopMode));
        CFHostCancelInfoResolution(host, self.networkHost.hostInfoType);
    }
}

@end
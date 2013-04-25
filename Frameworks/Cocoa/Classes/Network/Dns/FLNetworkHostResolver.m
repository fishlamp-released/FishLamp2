//
//  FLNetworkHostResolverStream.m
//  FLCore
//
//  Created by Mike Fullerton on 11/10/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLNetworkHostResolver.h"
#import "FLNetworkHost.h"
#import "NSError+FLNetworkStream.h"
#import "FLNetworkStream_Internal.h"

@interface FLNetworkHostResolver ()
@property (readwrite, strong) FLNetworkHost* networkHost;
@property (readwrite, strong) FLFinisher* finisher;
- (void) cancelRunLoop;
@end

@implementation FLNetworkHostResolver

@synthesize networkHost = _networkHost;
@synthesize finisher = _finisher;

- (id) init {
    self = [super init];
    if(self) {
    }
    
    return self;
}

- (void) dealloc {
    [self cancelRunLoop];
    
#if FL_MRC
    [_finisher release];
    [_networkHost release];
    [super dealloc];
#endif
}

+ (id) networkHostResolver {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) resolutionCallback:(CFHostRef) theHost
                   typeInfo:(CFHostInfoType) typeInfo
                      error:(const CFStreamError*) error {
    
    [self touchTimeoutTimestamp];
    
    FLAssertAreEqualWithComment(self.networkHost.hostRef, theHost, nil);
    FLAssertAreEqualWithComment(self.networkHost.hostInfoType, typeInfo, nil);
    
    id result = nil;
    
    if(error && error->domain != 0 && error->error != 0) {
        result = FLCreateErrorFromStreamError(error);
    }
    else {
        self.networkHost.resolved = YES;
        result = self.networkHost;
    }
    
    [self closeWithResult:result];
}

static void HostResolutionCallback(CFHostRef theHost, CFHostInfoType typeInfo, const CFStreamError *error, void *info) {
    FLNetworkHostResolver* resolver = bridge_(id, info);
    FLAssertIsKindOfClassWithComment(resolver, FLNetworkHostResolver, nil);
    [resolver resolutionCallback:theHost typeInfo:typeInfo error:error];
}

- (void) cancelRunLoop {
    if(self.isOpen) {
        CFHostRef host = self.networkHost.hostRef;
        if(host) {
            /*BOOL success = */ CFHostSetClient(host, NULL, NULL);
            CFHostUnscheduleFromRunLoop(host, [[self.eventHandler runLoop] getCFRunLoop], bridge_(void*,self.eventHandler.runLoopMode));
            CFHostCancelInfoResolution(host, self.networkHost.hostInfoType);
        }
    }
}

- (void) closeWithResult:(id) result {
    [self cancelRunLoop];
    [self.finisher setFinishedWithResult:result];
    self.finisher = nil;
    self.networkHost = nil;
}

- (id<FLAsyncResult>) resolveHostSynchronously:(FLNetworkHost*) host {
    id<FLAsyncResult> result = [[self startResolvingHost:host] waitUntilFinished];
    FLThrowIfError(result);
    return result;
}

- (FLFinisher*) startResolvingHost:(FLNetworkHost*) host {
    self.finisher = [FLFinisher finisher];
    FLAssertWithComment(!self.isOpen, @"already running");
    
    self.networkHost = host;
    
    CFHostClientContext context = { 0, bridge_(void*, self), NULL, NULL, NULL };
  
    CFHostRef cfhost = self.networkHost.hostRef;
    FLAssertIsNotNilWithComment(cfhost, nil);

    if (!CFHostSetClient(cfhost, HostResolutionCallback, &context)) {
        [self closeWithResult:[NSError errorWithDomain:NSPOSIXErrorDomain code:EINVAL userInfo:nil]];
        
    }
    else {
        CFHostScheduleWithRunLoop(cfhost, [[self.eventHandler runLoop] getCFRunLoop], bridge_(void*,self.eventHandler.runLoopMode));
        CFStreamError streamError = { 0, 0 };
        if (!CFHostStartInfoResolution(cfhost, self.networkHost.hostInfoType, &streamError) ) {
            [self closeWithResult:FLCreateErrorFromStreamError(&streamError)];
        }
    }
    return self.finisher;
}

@end
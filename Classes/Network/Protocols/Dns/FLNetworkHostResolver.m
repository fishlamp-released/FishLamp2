//
//  FLNetworkHostResolver.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLNetworkHostResolver.h"
#import "FLNetworkStream.h"
#import "FLNetworkHostResolverStream.h"

@interface FLNetworkHostResolver ()
@property (readwrite, retain, nonatomic) FLNetworkHost* networkHost;
@end

@implementation FLNetworkHostResolver

synthesize_(networkHost)

- (id) initWithNetworkHost:(FLNetworkHost*) host {
    self = [super init];
    if(self) {
        self.networkHost = host;
    }
    return self;
}

+ (FLNetworkHostResolver*) networkHostResolver:(FLNetworkHost*) host {
    return autorelease_([[FLNetworkHostResolver alloc] initWithNetworkHost:host]);
}

- (id<FLNetworkStream>) createNetworkStream {
    return autorelease_([[FLNetworkHostResolverStream alloc] initWithNetworkHost:self.networkHost]);
}

dealloc_(
    [_networkHost release];
)

@end



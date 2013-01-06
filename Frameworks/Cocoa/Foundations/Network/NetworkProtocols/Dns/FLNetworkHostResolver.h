//
//  FLNetworkHostResolverStream.h
//  FLCore
//
//  Created by Mike Fullerton on 11/10/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"

#import "FLNetworkHost.h"
#import "FLNetworkStream.h"

@interface FLNetworkHostResolver : FLNetworkStream {
@private
    FLNetworkHost* _networkHost;
    FLFinisher* _finisher;
    BOOL _isOpen;
}

+ (id) networkHostResolver;

- (FLResult) resolveHostSynchronously:(FLNetworkHost*) host;
- (FLFinisher*) startResolvingHost:(FLNetworkHost*) host;


@end
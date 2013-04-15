//
//  FLNetworkHostResolverStream.h
//  FLCore
//
//  Created by Mike Fullerton on 11/10/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLNetworkStream.h"
#import "FLResult.h"
#import "FLNetworkHost.h"
#import "FLTimedObject.h"
#import "FLTimer.h"
#import "FLFinisher.h"

@interface FLNetworkHostResolver : FLNetworkStream {
@private
    FLNetworkHost* _networkHost;
    FLFinisher* _finisher;
}

+ (id) networkHostResolver;

- (FLResult) resolveHostSynchronously:(FLNetworkHost*) host;
- (FLFinisher*) startResolvingHost:(FLNetworkHost*) host;

- (void) closeWithResult:(FLResult) result;


@end
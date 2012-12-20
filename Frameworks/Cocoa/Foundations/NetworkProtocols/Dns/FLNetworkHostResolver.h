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

@interface FLNetworkHostResolver : FLNetworkStream<FLConcreteNetworkStream> {
@private
    FLNetworkHost* _networkHost;
}
@property (readonly, strong) FLNetworkHost* networkHost;

- (id) initWithNetworkHost:(FLNetworkHost*) networkHost;

@end
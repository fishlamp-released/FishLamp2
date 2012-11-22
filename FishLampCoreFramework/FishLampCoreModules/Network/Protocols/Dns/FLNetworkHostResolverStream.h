//
//  FLNetworkHostResolverStream.h
//  FishLampCore
//
//  Created by Mike Fullerton on 11/10/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLNetworkHost.h"
#import "FLAbstractNetworkStream.h"

@interface FLNetworkHostResolverStream : FLAbstractNetworkStream<FLConcreteNetworkStream> {
@private
    NSError* _error;
    FLNetworkHost* _networkHost;
    __unsafe_unretained id<FLNetworkStream> _controller;
}
@property (readonly, strong) FLNetworkHost* networkHost;

- (id) initWithNetworkHost:(FLNetworkHost*) networkHost;

@end
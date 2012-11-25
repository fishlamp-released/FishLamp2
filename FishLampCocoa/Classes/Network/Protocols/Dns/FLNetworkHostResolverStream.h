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
    FLNetworkHost* _networkHost;
}
@property (readonly, strong) FLNetworkHost* networkHost;

- (id) initWithNetworkHost:(FLNetworkHost*) networkHost;

@end
//
//  FLNetworkHostResolver.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLNetworkConnection.h"
#import "FLNetworkHost.h"

@interface FLNetworkHostResolver : FLNetworkConnection {
@private
    FLNetworkHost* _networkHost;
}

@property (readonly, retain, nonatomic) FLNetworkHost* networkHost;

- (id) initWithNetworkHost:(FLNetworkHost*) host;

+ (FLNetworkHostResolver*) networkHostResolver:(FLNetworkHost*) host;

@end

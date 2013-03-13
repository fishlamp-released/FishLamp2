//
//  FLNetworkHostResolverStream.h
//  FLCore
//
//  Created by Mike Fullerton on 11/10/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLResult.h"
#import "FLNetworkHost.h"
#import "FLTimedObject.h"
#import "FLTimer.h"
#import "FLFinisher.h"

@interface FLNetworkHostResolver : FLTimedObject {
@private
    FLNetworkHost* _networkHost;
    BOOL _open;
    
    FLFinisher* _finisher;
}

@property (readonly, assign, nonatomic, getter=isOpen) BOOL open;

+ (id) networkHostResolver;

- (FLResult) resolveHostSynchronously:(FLNetworkHost*) host;
- (FLFinisher*) startResolvingHost:(FLNetworkHost*) host;

- (void) closeWithResult:(FLResult) result;


@end
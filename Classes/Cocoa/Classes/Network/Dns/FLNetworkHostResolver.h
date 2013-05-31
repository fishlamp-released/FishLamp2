//
//  FLNetworkHostResolverStream.h
//  FLCore
//
//  Created by Mike Fullerton on 11/10/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaRequired.h"
#import "FLNetworkStream.h"
#import "FLAsyncResult.h"
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

- (FLPromisedResult) resolveHostSynchronously:(FLNetworkHost*) host;

- (FLPromise*) startResolvingHost:(FLNetworkHost*) host completion:(fl_completion_block_t) completion;

- (void) closeWithResult:(id) result;


@end
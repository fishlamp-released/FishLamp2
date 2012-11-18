//
//  FLNetworkHostResolverStream.h
//  FishLampCore
//
//  Created by Mike Fullerton on 11/10/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLNetworkStream.h"

@interface FLNetworkHostResolverStream : FLNetworkStream<FLNetworkStreamDelegate> {
@private
    NSError* _error;
}
@end
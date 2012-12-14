//
//  FLNetworkActivityConnectionObserver.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/11/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//
#import "FLCore.h"

#import "FLNetworkConnectionObserver.h"

@interface FLNetworkActivityConnectionObserver : NSObject<FLNetworkConnectionObserver> {
@private
}

+ (FLNetworkActivityConnectionObserver*) networkActivityConnectionObserver;

@end

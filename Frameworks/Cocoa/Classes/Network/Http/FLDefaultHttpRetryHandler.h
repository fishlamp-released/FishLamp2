//
//  FLDefaultHttpRetryHandler.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/20/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLRetryHandler.h"

#define FLDefaultHttpRetryCount 3
#define FLDefaultHttpRetryDelay 1.0

@interface FLDefaultHttpRetryHandler : FLRetryHandler

+ (id) defaultHttpRetryHandler;

@end

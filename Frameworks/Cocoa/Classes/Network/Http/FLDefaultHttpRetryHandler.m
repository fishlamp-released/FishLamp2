//
//  FLDefaultHttpRetryHandler.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/20/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLDefaultHttpRetryHandler.h"

static NSUInteger s_defaultRetryCount = 3;

@implementation FLDefaultHttpRetryHandler

- (id) init {	
	self = [super init];
	if(self) {
        self.maxRetryCount = FLDefaultHttpRetryCount;
        self.retryDelay = FLDefaultHttpRetryDelay;
	}
	return self;
}

+ (id) defaultHttpRetryHandler {
    return FLAutorelease([[[self class] alloc] init]);
}

@end

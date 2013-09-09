//
//	FLEmptyCacheOperation.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/20/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLEmptyCacheOperation.h"
#import "FLCacheManager.h"
#import "FishLampAsync.h"

@implementation FLEmptyCacheOperation

- (id) performSynchronously {
	[[FLCacheManager instance] broadcastEmptyCacheMessage:self];
    return [FLSuccessfulResult successfulResult];
}

+ (FLEmptyCacheOperation*) emptyCacheOperation {
    return FLAutorelease([[[self class] alloc] init]);   
}


@end

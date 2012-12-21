//
//	FLEmptyCacheOperation.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/20/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLEmptyCacheOperation.h"
#import "FLCacheManager.h"

@implementation FLEmptyCacheOperation

- (FLResult) runOperationWithInput:(id) input {
	[[FLCacheManager instance] broadcastEmptyCacheMessage:self];
    return FLSuccessfullResult;
}

+ (FLEmptyCacheOperation*) emptyCacheOperation {
    return FLAutorelease([[[self class] alloc] init]);   
}


@end

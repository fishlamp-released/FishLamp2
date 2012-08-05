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

- (void) performSelf
{
	[[FLCacheManager instance] broadcastEmptyCacheMessage:self];
}

+ (FLEmptyCacheOperation*) emptyCacheOperation {
    return FLReturnAutoreleased([[[self class] alloc] init]);   
}


@end

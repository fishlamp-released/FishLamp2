//
//	GtEmptyCacheOperation.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/20/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtEmptyCacheOperation.h"
#import "GtCacheManager.h"

@implementation GtEmptyCacheOperation

- (void) performSelf
{
	[[GtCacheManager instance] broadcastEmptyCacheMessage:self];
}

@end

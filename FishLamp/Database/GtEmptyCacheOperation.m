//
//  GtEmptyCacheOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/20/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtEmptyCacheOperation.h"
#import "GtDatabaseCache.h"
#import "GtImageCache.h"
#import "GtUserSession.h"

@implementation GtEmptyCacheOperation

- (void) onPerformOperation
{
	[[GtUserSession instance].objectCache clearCache];
	[[GtUserSession instance].imageCache clearCache];
}

@end

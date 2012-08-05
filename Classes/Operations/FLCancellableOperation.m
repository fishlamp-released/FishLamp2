//
//  FLCancellableOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/15/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLCancellableOperation.h"

@implementation FLCancellableOperation
@synthesize wasCancelled = _cancelled;

- (void) requestCancel
{
	_cancelled = YES;
}

- (void) throwIfCancelled
{
	if(_cancelled)
	{
		FLThrowError([NSError cancelError]);
	}	
}

@end

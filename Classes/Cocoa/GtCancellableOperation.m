//
//  GtCancellableOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/15/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtCancellableOperation.h"

@implementation GtCancellableOperation
@synthesize wasCancelled = m_cancelled;

- (void) requestCancel
{
	m_cancelled = YES;
}

- (void) throwIfCancelled
{
	if(m_cancelled)
	{
		GtThrowError([NSError cancelError]);
	}	
}

@end

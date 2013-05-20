//
//  GtBlocks.m
//  Fishlamp
//
//  Created by Mike Fullerton on 6/20/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtBlocks.h"

#import <mach/mach_time.h>  // for mach_absolute_time() and friends

float GtTimeBlock(GtBlock block)  {
    mach_timebase_info_data_t info;
    if (mach_timebase_info(&info) != KERN_SUCCESS)  {
        return -1.0;
    }

    uint64_t start = mach_absolute_time ();
    block ();
    uint64_t end = mach_absolute_time ();
    uint64_t elapsed = end - start;

    uint64_t nanos = elapsed * info.numer / info.denom;
    return (float)nanos / (float) NSEC_PER_SEC;
} 

void GtDrainPool(NSAutoreleasePool** pool) {
    if(pool) {
        [*pool drain];
        *pool = nil;
    }
}

void GtDrainPoolAndRethrow(NSAutoreleasePool** pool, NSException* ex) {
    [ex retain];
    GtDrainPool(pool);
    [ex autorelease];
    @throw ex;
}

#if ! __has_feature(objc_arc)
void GtPerformBlockInAutoreleasePool(void (^callback)())
{
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    @try {
        if(callback) {
            callback();
        }
        GtDrainPool(&pool);
    }
    @catch(id exception) {
        [exception retain];
        [pool drain];
        [exception autorelease];
        @throw;
    }
}
#endif

id GtCopyOrRetainObject(id src)
{	
	if([src conformsToProtocol:@protocol(NSMutableCopying)])
	{
		return GtReturnAutoreleased([src mutableCopy]);
	}
	else if([src conformsToProtocol:@protocol(NSCopying)])
	{
		return GtReturnAutoreleased([src copy]);
	}
	else
	{
		return GtReturnAutoreleased(GtReturnRetained(src));
	}
	
	return nil;
}

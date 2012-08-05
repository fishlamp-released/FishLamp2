//
//  FLBlocks.m
//  Fishlamp
//
//  Created by Mike Fullerton on 6/20/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLBlocks.h"

#import <mach/mach_time.h>  // for mach_absolute_time() and friends

float FLTimeBlock(FLEventCallback block)  {
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


#if ! __has_feature(objc_arc)
void FLPerformBlockInAutoreleasePool(void (^callback)())
{
    NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
    @try {
        if(callback) {
            callback();
        }
        [pool drain];
    }
    @catch(id exception) {
        [exception retain];
        [pool drain];
        [exception autorelease];
        @throw;
    }
}
#endif

id FLCopyOrRetainObject(id src)
{	
	if([src conformsToProtocol:@protocol(NSMutableCopying)])
	{
		return FLReturnAutoreleased([src mutableCopy]);
	}
	else if([src conformsToProtocol:@protocol(NSCopying)])
	{
		return FLReturnAutoreleased([src copy]);
	}
	else
	{
		return FLReturnAutoreleased(FLReturnRetained(src));
	}
	
	return nil;
}

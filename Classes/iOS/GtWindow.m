//
//  GtWindow.m
//  myZenfolio
//
//  Created by Mike Fullerton on 5/21/13.
//
//

#import "GtWindow.h"

@implementation GtWindow

- (id) init {	
	self = [super init];
	if(self) {
		
	}
	return self;
}

//+ (GtApplication*) sharedApplication
//{
//	return (GtApplication*) [UIApplication sharedApplication];
//}

- (void) dealloc
{
    GtRelease(m_eventInterceptors);
	GtSuperDealloc();
}

- (void) addEventInterceptor:(id<GtEventInterceptor>) interceptor
{
	if(!m_eventInterceptors)
	{
		m_eventInterceptors = [[NSMutableArray alloc] init];
	}
	[m_eventInterceptors addObject:[NSValue valueWithNonretainedObject:interceptor]];
}

- (void) removeEventInterceptor:(id<GtEventInterceptor>) interceptor
{
	for(NSUInteger i = 0; i < m_eventInterceptors.count; i++)
	{
		if([[m_eventInterceptors objectAtIndex:i] nonretainedObjectValue] == interceptor)
		{
			[m_eventInterceptors removeObjectAtIndex:i];
			break;
		}
	}
}

- (BOOL) hasEventInterceptor:(id<GtEventInterceptor>) interceptor
{
	for(NSUInteger i = 0; i < m_eventInterceptors.count; i++)
	{
		if([[m_eventInterceptors objectAtIndex:i] nonretainedObjectValue] == interceptor)
		{
            return YES;
        }
	}
    
    return NO;
}

- (BOOL) didInterceptEvent:(UIEvent*) event
{
    if(m_eventInterceptors && m_eventInterceptors.count)
	{
		for(NSValue* receiver in m_eventInterceptors)
		{
			if([receiver.nonretainedObjectValue didInterceptEvent:event])
			{
				return YES;
			}
		}
	}
    
    return NO;
}

- (void)sendEvent:(UIEvent *)event 
{
    if(![self didInterceptEvent:event])
	{
		[super sendEvent:event];
	}
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
//	if(self == [GtWindow topWindow])
	{
		if (event.type == UIEventSubtypeMotionShake) 
		{
			[[NSNotificationCenter defaultCenter] postNotificationName:GtDeviceWasShakenNotification object:[UIApplication sharedApplication]];
		}
	}
	
	if ( [super respondsToSelector:@selector(motionEnded:withEvent:)] )
	{
		[super motionEnded:motion withEvent:event];
	}
}

//- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
//{
//	if ( [super respondsToSelector:@selector(motionCancelled:withEvent:)] )
//	{
//		[super motionCancelled:motion withEvent:event];
//	}
//}
//
//- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
//{
//	if ( [super respondsToSelector:@selector(motionBegan:withEvent:)] )
//	{
//		[super motionBegan:motion withEvent:event];
//	}
//}


@end


@implementation UIWindow (GtEventInterceptor)
- (void) addEventInterceptor:(id<GtEventInterceptor>) eventReceiver {
}
- (void) removeEventInterceptor:(id<GtEventInterceptor>) eventReceiver {
}
- (BOOL) hasEventInterceptor:(id<GtEventInterceptor>) eventReceiver {
    return NO;
}
@end

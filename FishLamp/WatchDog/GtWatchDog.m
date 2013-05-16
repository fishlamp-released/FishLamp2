//
//  GtWatchDog.m
//  FishLamp
//
//  Created by Mike Fullerton on 8/19/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#if GT_WATCHDOG

#import "GtWatchDog.h"
#import "NSObject(GtWatchDog).h"
#import "GtWatchDogObjectContainer.h"

#import <objc/objc-class.h>

#define OBJECT_KEY(OBJ) [NSNumber numberWithUnsignedLong:(unsigned long) ((void*) OBJ)]

@implementation GtWatchDog

GtSynthesizeSingleton(GtWatchDog);

- (id) init
{
	if(self = [super init])
	{
		m_snapshots = [GtAlloc(NSMutableArray) init];
		m_objects = [GtAlloc(NSMutableDictionary) init];
		
		[self startTrackingLeaks];
	}
	
	return self;
}

- (NSMutableDictionary*) currentSnapshot
{
	return m_snapshots.count > 0 ? [m_snapshots lastObject] : nil;
}

- (NSMutableDictionary*) findSnapshotForObject:(NSString*) key
{
	for(int i = m_snapshots.count -1; i >= 0; i--)
	{
		NSMutableDictionary* current = [m_snapshots lastObject];
		id object = [current objectForKey:key];
		if(object)
		{
			return current;	
		}
	}
	
	return nil;
}

- (GtWatchDogObjectContainer*) findObjectInSnapshot:(id) object
{
	NSString* key = [GtWatchDog objectKey:object];
	NSMutableDictionary* objects = [self findSnapshotForObject:key];
	if(objects)
	{
		return [objects objectForKey:key];
	}
	
	return nil;
}

- (void) retainObject:(id) object
{
}

- (void) releaseObject:(id) object
{
//	GtWatchDogObjectContainer* container = [m_objects objectForKey:OBJECT_KEY(object)];
//	container.autoreleaseCalled = YES;
}

- (void) autoreleaseObject:(id) object
{
	GtWatchDogObjectContainer* container = [m_objects objectForKey:OBJECT_KEY(object)];
	container.autoreleaseCalled = YES;
}

- (void) deallocObject:(id) object
{
	NSString* key = [GtWatchDog objectKey:object];
	
	if(m_snapshots.count > 0)
	{
		NSMutableDictionary* snapshot = [self findSnapshotForObject:key];
		if(snapshot)
		{
			[snapshot removeObjectForKey:key];
		}
	}
	[m_objects removeObjectForKey:key];
}

- (void) log:(NSString*) logString
{
	NSLog(logString);
}

+ (id) objectKey:(id) obj
{
	return OBJECT_KEY(obj);
//	return [NSString stringWithFormat:@"%@-%x", NSStringFromClass([obj class]), (void*) obj];
}

- (id) registerObject:(NSObject*) object file:(const char*) file function:(const char*) function line:(int) line
{
	[object setupStuff];
	
	GtWatchDogObjectContainer* container = [[[GtWatchDogObjectContainer alloc] init] autorelease];
	
	container.object = object;
	container.function = [NSString stringWithCString:function encoding:NSASCIIStringEncoding];
	container.file = [NSString stringWithCString:function encoding:NSASCIIStringEncoding];
	container.line = line;
	
	NSString* key = [GtWatchDog objectKey:object];
	
	[m_objects setObject:container forKey:key];
	if(m_snapshots.count > 0)
	{
		[[self currentSnapshot] setObject:container forKey:key];
	}
	return object;
}

- (void) releaseObject:(NSObject*) object 
	file:(const char*) file 
	function:(const char*) function 
	line:(int) line
{
}

- (void) startTrackingLeaks
{
	[m_snapshots addObject:[NSMutableDictionary dictionary]]; 
}

- (void) stopTrackingLeaks
{
	if(m_snapshots.count > 0)
	{
		NSMutableDictionary* current = [m_snapshots lastObject];
		
		if(current.count > 0)
		{
			
		}
	}
}


@end

@implementation NSObject (GtWatchDog)

-(id)original_retain
{
// not called after redirect
	return self;
}
- (id) original_autorelease
{
// not called after redirect
	return self;
}
- (oneway void) original_release
{
// not called after redirect
}
- (void) original_dealloc
{
// not called after redirect
}

// replacement methods
- (id)watchdog_retain
{	
	[self original_retain];
	[[GtWatchDog instance] retainObject:self];
	return self;
}

- (oneway void)watchdog_release
{
	[[GtWatchDog instance] releaseObject:self];
	[self original_release];
}

- (id) watchdog_autorelease
{
	[[GtWatchDog instance] autoreleaseObject:self];
	return [self original_autorelease];
}

- (void) watchdog_dealloc
{
	[[GtWatchDog instance] deallocObject:self];
	return [self original_dealloc];
}

- (void) setImps:(SEL) original new:(SEL) new old:(SEL)old
{
	Method originalRetain = class_getInstanceMethod([self class], @selector(original));
	Method myRetain = class_getInstanceMethod([self class], @selector(new));
	Method oldRetain = class_getInstanceMethod([self class], @selector(old));

	IMP originalImp = method_getImplementation(originalRetain);
	IMP myImp = method_getImplementation(myRetain);

	if(originalImp != myImp)
	{
		method_setImplementation(oldRetain, originalImp);
		method_setImplementation(originalRetain, myImp);
	}
}

- (void) setupStuff
{
	[self setImps:@selector(retain) new:@selector(watchdog_retain) old:@selector(original_retain)];
	[self setImps:@selector(release) new:@selector(watchdog_release) old:@selector(original_release)];
	[self setImps:@selector(autorelease) new:@selector(watchdog_autorelease) old:@selector(original_autorelease)];
	[self setImps:@selector(dealloc) new:@selector(watchdog_dealloc) old:@selector(original_dealloc)];
}

@end

#endif
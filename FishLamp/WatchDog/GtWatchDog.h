//
//  GtWatchDog.h
//  FishLamp
//
//  Created by Mike Fullerton on 8/19/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#import "GtWatchDogMacros.h"

#if GT_WATCHDOG

@interface GtWatchDog : NSObject {
	NSMutableDictionary* m_objects;
	NSMutableArray* m_snapshots;
}

+ (GtWatchDog*) instance;

- (void) log:(NSString*) log;

- (void) startTrackingLeaks;
- (void) stopTrackingLeaks;

@end

@interface GtWatchDog (Internal)
+ (id) objectKey:(id) obj;
- (void) retainObject:(id) object;
- (void) releaseObject:(id) object;
- (void) autoreleaseObject:(id) object;
- (void) deallocObject:(id) object;
- (id) registerObject:(NSObject*) object 
	file:(const char*) file 
	function:(const char*) function 
	line:(int) line;
- (void) releaseObject:(NSObject*) object 
	file:(const char*) file 
	function:(const char*) function 
	line:(int) line;
@end


#endif
//
//  GtWatchDogMacros.h
//  FishLamp
//
//  Created by Mike Fullerton on 8/19/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#if GT_WATCHDOG
	#define GT_SAVEWDCONTEXT [[GtWatchDog instance] saveContext:__FILE__ function:__PRETTY_FUNCTION__ line:__LINE__]

	#define GtAlloc(TYPE) ((TYPE*) [[GtWatchDog instance] registerObject:[TYPE alloc] file:__FILE__ function:__PRETTY_FUNCTION__ line:__LINE__]) 
	#define GtRelease(OBJ) [[GtWatchDog instance] releaseObject:(OBJ) file:__FILE__ function:__PRETTY_FUNCTION__ line:__LINE__]
	#define GtWatch(OBJ) [[GtWatchDog instance] registerObject:(OBJ) file:__FILE__ function:__PRETTY_FUNCTION__ line:__LINE__]

	#define GtAssertDeleted(OBJ)
//	#define GtDelete(OBJ) GtRelease(OBJ); GtAssertDeleted(OBJ)
	
#else
	#define GT_SAVEWDCONTEXT
	#define GtAssertDeleted(OBJ)
	
	#define GtAlloc(TYPE) [TYPE alloc]
	#define GtRelease(OBJ) [OBJ release]
//	#define GtDelete(OBJ) do { if(OBJ) { GtRelease(OBJ); GtAssertDeleted(OBJ); OBJ = nil; } } while(0)
	#define GtWatch(OBJ) OBJ
	
	
	// OBSOLETE
	#define gtAlloc gtAlloc_has_been_renamed_to_GtAlloc
	#define gtRelease gtRelease_has_been_renamed_to_GtRelease

#endif
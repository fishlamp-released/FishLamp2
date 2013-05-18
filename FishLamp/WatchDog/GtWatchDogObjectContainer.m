//
//  GtWatchDogObjectContainer.m
//  FishLamp
//
//  Created by Mike Fullerton on 8/19/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#if GT_WATCHDOG

#import "GtWatchDogObjectContainer.h"
#import "GtWatchDog.h"

@implementation GtWatchDogObjectContainer

@synthesize object = m_object;
GtSynthesizeString(file, setFile);
GtSynthesizeString(function, setFunction);
@synthesize line = m_line;
@synthesize autoreleaseCalled = m_autoreleaseCalled;

- (NSString*) description
{
	return [NSString stringWithFormat:
		@"%@-%@: Allocated in: %@, Function: %@, line: %d, retainCount: %d, autorelease: %@", 
			NSStringFromClass([m_object class]),
			[GtWatchDog objectKey:m_object],
			[m_file lastPathComponent],
			m_function,
			m_line,
			[m_object retainCount],
			m_autoreleaseCalled ? @"YES" : @"NO"];
}

@end

#endif
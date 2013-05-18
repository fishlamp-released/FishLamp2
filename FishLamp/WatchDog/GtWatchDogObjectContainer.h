//
//  GtWatchDogObjectContainer.h
//  FishLamp
//
//  Created by Mike Fullerton on 8/19/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#if GT_WATCHDOG


@interface GtWatchDogObjectContainer : NSObject
{
	id m_object;
	NSString* m_function;
	NSString* m_file;
	int m_line;
	BOOL m_autoreleaseCalled;
}

@property (readwrite, assign) id object;
@property (readwrite, assign) NSString* file;
@property (readwrite, assign) NSString* function;
@property (readwrite, assign) int line;
@property (readwrite, assign) BOOL autoreleaseCalled;

@end
#endif
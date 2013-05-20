//
//	GtUserPreferences.m
//	FishLamp
//
//	Created by Mike Fullerton on 11/4/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtUserPreferences.h"
#import "NSFileManager+GtExtras.h"
#import "GtUserSession.h"

#define kFileName @"prefs.plist"


@implementation GtUserPreferences

- (id) init
{
	if((self = [super initWithFolder:[GtUserSession instance].documentsFolder fileName:kFileName]))
	{
	}
	
	return self;
}

- (id) initWithCoder:(NSCoder*) aDecoder
{
	if((self = [super initWithFolder:[GtUserSession instance].documentsFolder fileName:kFileName]))
	{
	}
	
	return self;
}

- (void) setDefaults
{
}

- (BOOL) readFromFile
{
	if(![super readFromFile])
	{
		[self setDefaults];
		return NO;
	}

	return YES;
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
}

@end

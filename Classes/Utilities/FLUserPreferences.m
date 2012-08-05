//
//	FLUserPreferences.m
//	FishLamp
//
//	Created by Mike Fullerton on 11/4/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLUserPreferences.h"
#import "NSFileManager+FLExtras.h"
#import "FLUserSession.h"

#define kFileName @"prefs.plist"


@implementation FLUserPreferences

- (id) init
{
	if((self = [super initWithFolder:[FLUserSession instance].documentsFolder fileName:kFileName]))
	{
	}
	
	return self;
}

- (id) initWithCoder:(NSCoder*) aDecoder
{
	if((self = [super initWithFolder:[FLUserSession instance].documentsFolder fileName:kFileName]))
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

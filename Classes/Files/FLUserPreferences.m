//
//	FLUserPreferences.m
//	FishLamp
//
//	Created by Mike Fullerton on 11/4/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLUserPreferences.h"
#import "NSFileManager+FLExtras.h"

#define kFileName @"prefs.plist"

@implementation FLUserPreferences

- (id) initWithFolder:(FLFolder*) folder {
	if((self = [super initWithFolder:folder fileName:kFileName])) {
	}
	
	return self;
}

- (id) initWithCoder:(NSCoder*) aDecoder {
	if((self = [super init])) {
	}
	
	return self;
}

- (void) setDefaults {
}

- (BOOL) readFromFile {
	if(![super readFromFile]) {
		[self setDefaults];
		return NO;
	}

	return YES;
}

- (void) encodeWithCoder:(NSCoder*) aCoder {
}

@end

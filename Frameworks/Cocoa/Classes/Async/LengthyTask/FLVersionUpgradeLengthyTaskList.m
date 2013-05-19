//
//  FLVersionUpgradeLengthyTaskList.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/4/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLVersionUpgradeLengthyTaskList.h"

@implementation FLVersionUpgradeLengthyTaskList

@synthesize fromVersion = _fromVersion;
@synthesize toVersion = _toVersion;

- (id) initWithFromVersion:(NSString*) fromVersion toVersion:(NSString*) toVersion {
	if((self = [super init])) {
		_fromVersion = FLRetain(fromVersion);
		_toVersion = FLRetain(toVersion);
	}
	
	return self;
}

#if FL_MRC
- (void) dealloc {
    FLRelease(_fromVersion);
    FLRelease(_toVersion);
    [super dealloc];
}
#endif

+ (FLVersionUpgradeLengthyTaskList*) versionUpgradeLengthyTaskList:(NSString*) fromVersion toVersion:(NSString*) toVersion
{
	return FLAutorelease([[FLVersionUpgradeLengthyTaskList alloc] initWithFromVersion:fromVersion toVersion:toVersion]);
}

@end

//
//  FLVersionUpgradeLengthyTaskList.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/4/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLVersionUpgradeLengthyTaskList.h"

@implementation FLVersionUpgradeLengthyTaskList

@synthesize fromVersion = _fromVersion;
@synthesize toVersion = _toVersion;

- (id) initWithFromVersion:(NSString*) fromVersion toVersion:(NSString*) toVersion
{
	if((self = [super init]))
	{
		_fromVersion = retain_(fromVersion);
		_toVersion = retain_(toVersion);
	}
	
	return self;
}

- (void) dealloc
{
    release_(_fromVersion);
    release_(_toVersion);
    super_dealloc_();
}

+ (FLVersionUpgradeLengthyTaskList*) versionUpgradeLengthyTaskList:(NSString*) fromVersion toVersion:(NSString*) toVersion
{
	return autorelease_([[FLVersionUpgradeLengthyTaskList alloc] initWithFromVersion:fromVersion toVersion:toVersion]);
}

@end

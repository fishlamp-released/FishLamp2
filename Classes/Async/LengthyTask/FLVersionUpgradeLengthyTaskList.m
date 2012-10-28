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
		_fromVersion = FLReturnRetained(fromVersion);
		_toVersion = FLReturnRetained(toVersion);
	}
	
	return self;
}

- (void) dealloc
{
    FLRelease(_fromVersion);
    FLRelease(_toVersion);
    FLSuperDealloc();
}

+ (FLVersionUpgradeLengthyTaskList*) versionUpgradeLengthyTaskList:(NSString*) fromVersion toVersion:(NSString*) toVersion
{
	return FLReturnAutoreleased([[FLVersionUpgradeLengthyTaskList alloc] initWithFromVersion:fromVersion toVersion:toVersion]);
}

@end

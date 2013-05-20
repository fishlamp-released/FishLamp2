//
//  GtVersionUpgradeLengthyTaskList.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/4/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtVersionUpgradeLengthyTaskList.h"

@implementation GtVersionUpgradeLengthyTaskList

@synthesize fromVersion = m_fromVersion;
@synthesize toVersion = m_toVersion;

- (id) initWithFromVersion:(NSString*) fromVersion toVersion:(NSString*) toVersion
{
	if((self = [super init]))
	{
		m_fromVersion = GtRetain(fromVersion);
		m_toVersion = GtRetain(toVersion);
	}
	
	return self;
}

- (void) dealloc
{
    GtRelease(m_fromVersion);
    GtRelease(m_toVersion);
    GtSuperDealloc();
}

+ (GtVersionUpgradeLengthyTaskList*) versionUpgradeLengthyTaskList:(NSString*) fromVersion toVersion:(NSString*) toVersion
{
	return GtReturnAutoreleased([[GtVersionUpgradeLengthyTaskList alloc] initWithFromVersion:fromVersion toVersion:toVersion]);
}

@end

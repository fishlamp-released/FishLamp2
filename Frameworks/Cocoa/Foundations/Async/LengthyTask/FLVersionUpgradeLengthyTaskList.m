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

- (id) initWithFromVersion:(NSString*) fromVersion toVersion:(NSString*) toVersion {
	if((self = [super initWithActionType:FLActionTypeUpdate])) {
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

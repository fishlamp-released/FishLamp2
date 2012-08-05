//
//  FLVersion.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/9/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//
#import <Foundation/Foundation.h>

typedef struct {
	int major;
	int minor;
	int revision;
    int build;
} FLVersion;

extern const FLVersion FLVersionZero;

extern FLVersion FLVersionFromString(NSString* versionString);

extern NSString* FLStringFromVersion(FLVersion version);

NS_INLINE
FLVersion FLVersionMake(int major, int minor, int revision, int build) 
{
    FLVersion version = { major, minor, revision, build };
    return version;
}


NS_INLINE 
BOOL FLVersionEqualToVersion(FLVersion lhs, FLVersion rhs) 
{
	return lhs.major == rhs.major && lhs.minor == rhs.minor && lhs.revision == rhs.revision && lhs.build == rhs.build;
}

NS_INLINE 
BOOL FLVersionLessThanVersion(FLVersion lhs, FLVersion rhs) 
{
	return lhs.major < rhs.major || 
		(lhs.major == rhs.major && lhs.minor < rhs.minor) || 
		(lhs.major == rhs.major && lhs.minor == rhs.minor && lhs.revision < rhs.revision) || 
        (lhs.major == rhs.major && lhs.minor == rhs.minor && lhs.revision == rhs.revision && lhs.build < rhs.build);
}


NS_INLINE 
BOOL FLVersionLessThanEqualToVersion(FLVersion lhs, FLVersion rhs) 
{
	return lhs.major < rhs.major || 
		(lhs.major == rhs.major && lhs.minor < rhs.minor) || 
		(lhs.major == rhs.major && lhs.minor == rhs.minor && lhs.revision <= rhs.revision)|| 
        (lhs.major == rhs.major && lhs.minor == rhs.minor && lhs.revision == rhs.revision && lhs.build <= rhs.build);;
}

#define FLVersionGreaterThanVersion(lhs, rhs) FLVersionLessThanVersion(rhs, lhs)
#define FLVersionGreaterThanEqualToVersion(lhs, rhs) FLVersionLessThanEqualToVersion(rhs, lhs)



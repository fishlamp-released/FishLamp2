//
//  GtVersion.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/9/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#import "FishLampMinimum.h"

typedef struct {
	int major;
	int minor;
	int revision;
    int build;
} GtVersion;

extern const GtVersion GtVersionZero;

extern GtVersion s_osVersion;
extern void GtSetOSVersion();

extern GtVersion GtVersionFromString(NSString* versionString);
extern NSString* GtStringFromVersion(GtVersion version);

NS_INLINE BOOL GtVersionEqualToVersion(GtVersion lhs, GtVersion rhs)
{
	return lhs.major == rhs.major && lhs.minor == rhs.minor && lhs.revision == rhs.revision && lhs.build == rhs.build;
}

NS_INLINE BOOL GtVersionLessThanVersion(GtVersion lhs, GtVersion rhs)
{
	return lhs.major < rhs.major || 
		(lhs.major == rhs.major && lhs.minor < rhs.minor) || 
		(lhs.major == rhs.major && lhs.minor == rhs.minor && lhs.revision < rhs.revision) || 
        (lhs.major == rhs.major && lhs.minor == rhs.minor && lhs.revision == rhs.revision && lhs.build < rhs.build);
}

#define GtVersionGreaterThanVersion(lhs, rhs) GtVersionLessThanVersion(rhs, lhs)

NS_INLINE BOOL GtVersionLessThanEqualToVersion(GtVersion lhs, GtVersion rhs)
{
	return lhs.major < rhs.major || 
		(lhs.major == rhs.major && lhs.minor < rhs.minor) || 
		(lhs.major == rhs.major && lhs.minor == rhs.minor && lhs.revision <= rhs.revision)|| 
        (lhs.major == rhs.major && lhs.minor == rhs.minor && lhs.revision == rhs.revision && lhs.build <= rhs.build);;
}

#define GtVersionGreaterThanEqualToVersion(lhs, rhs) GtVersionLessThanEqualToVersion(rhs, lhs)


#if IOS
    #if __IPHONE_4_0
        #define OSVersionIsAtLeast4_0() (s_osVersion.major >= 4)
        #define OSVersionIsAtLeast4_1() (s_osVersion.major > 4 || (s_osVersion.major == 4 && s_osVersion.minor >= 1))

    #else
        #define OSVersionIsAtLeast4_0() NO
    #endif

    #if __IPHONE_3_2
        #define OSVersionIsAtLeast3_2() (s_osVersion.major > 3 || (s_osVersion.major == 3 && s_osVersion.minor >= 2))
    #else
        #define OSVersionIsAtLeast3_2() NO
    #endif
#endif
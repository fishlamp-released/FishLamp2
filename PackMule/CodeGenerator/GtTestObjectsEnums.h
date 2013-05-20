//	This file was generated at 7/20/11 6:51 PM by PackMule. DO NOT MODIFY!!
//
//	GtTestObjectsEnums.h
//	Project: FishLamp
//	Schema: GtTestObjects
//
//	Copywrite 2011 GreentTongue Software. All rights reserved.
//


#define kGtMyEnumfoo @"foo"
#define kGtMyEnumbar @"bar"
#define kGtMyEnumfoobar @"foobar"

typedef enum {
	GtMyEnumfoo,
	GtMyEnumbar,
	GtMyEnumfoobar,
} GtMyEnum;


@interface GtTestObjectsEnumLookup : NSObject {
	NSDictionary* m_strings;
}
GtSingletonProperty(GtTestObjectsEnumLookup);
- (NSString*) stringFromMyEnum:(GtMyEnum) inEnum;
- (GtMyEnum) myEnumFromString:(NSString*) inString;
@end

//	This file was generated at 6/22/11 1:04 PM by PackMule. DO NOT MODIFY!!
//
//	GtTestObjectsEnums.m
//	Project: FishLamp
//	Schema: GtTestObjects
//
//	Copywrite 2011 GreentTongue Software. All rights reserved.
//

#import "GtTestObjectsEnums.h"
@implementation GtTestObjectsEnumLookup
GtSynthesizeSingleton(GtTestObjectsEnumLookup);
- (id) init {
	if((self = [super init])) {
		m_strings = [[NSDictionary alloc] initWithObjectsAndKeys:
			[NSNumber numberWithInt:GtMyEnumfoo], kGtMyEnumfoo, 
			[NSNumber numberWithInt:GtMyEnumbar], kGtMyEnumbar, 
			[NSNumber numberWithInt:GtMyEnumfoobar], kGtMyEnumfoobar, 
		 nil];
	}
	return self;
}

- (NSInteger) lookupString:(NSString*) inString {
	NSNumber* num = [m_strings objectForKey:inString];
	if(!num) { return NSNotFound; } 
	return [num intValue];
}

- (NSString*) stringFromMyEnum:(GtMyEnum) inEnum {
	switch(inEnum) {
		case GtMyEnumfoo: return kGtMyEnumfoo;
		case GtMyEnumbar: return kGtMyEnumbar;
		case GtMyEnumfoobar: return kGtMyEnumfoobar;
	}
	return nil;
}

- (GtMyEnum) myEnumFromString:(NSString*) inString {
	return (GtMyEnum) [self lookupString:inString];
}

@end

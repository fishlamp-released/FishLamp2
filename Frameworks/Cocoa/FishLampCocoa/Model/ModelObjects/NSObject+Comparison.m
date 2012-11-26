//
//	NSObject+Comparison.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/14/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "NSObject+Comparison.h"
#import "FLStringUtils.h"

@implementation NSObject (FLComparison)
+ (BOOL) objectIsEqualToObject:(id) object toObject:(id) anotherObject {
	return FLObjectsAreEqual(object, anotherObject);
}
@end

@implementation NSString (FLComparison)
+ (BOOL) objectIsEqualToObject:(id) object toObject:(id) anotherObject {
	return FLStringsAreEqual(object, anotherObject);
}
@end
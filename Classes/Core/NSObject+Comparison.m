//
//	NSObject+Comparison.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/14/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "NSObject+Comparison.h"


@implementation NSObject (GtComparison)
+ (BOOL) objectIsEqual:(id) object toObject:(id) anotherObject {
	return object == anotherObject || [object isEqual:anotherObject];
}
@end

@implementation NSString (GtComparison)
+ (BOOL) objectIsEqual:(id) object toObject:(id) anotherObject {
	return GtStringsAreEqual(object, anotherObject);
}
@end
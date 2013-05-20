//
//	GtMutableArray.m
//	FishLamp
//
//	Created by Mike Fullerton on 7/27/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "NSArray+GtExtras.h"

@implementation NSArray (GtExtras)
- (NSUInteger) indexOfLastObject {
	return self.count > 0 ? self.count - 1 : NSNotFound;
}
- (id) firstObject {
	return [self objectAtIndex:0];
}
@end

@implementation NSMutableArray (GtExtras)

- (void) moveObjectToNewIndex:(NSUInteger) fromIndex toIndex:(NSUInteger) toIndex {
	GtAssert(fromIndex < (NSUInteger)self.count, @"bad from idx");
	GtAssert(toIndex < (NSUInteger)self.count, @"bad from idx");

	if(fromIndex != toIndex) {
		id object = [self objectAtIndex:fromIndex];
		GtRetain(object);
        
        [self removeObjectAtIndex:fromIndex];
		
		if(toIndex == self.count) {
			[self addObject:object];
		}
		else {
			[self insertObject:object atIndex:toIndex];
		}
		
        GtRelease(object);
	}
	
}

- (void) addObject:(id) object configureObject:(void (^)(id object)) configureObject {
    if(configureObject) {
        configureObject(object);
    }
    
    [self addObject:object];
}

- (id) dequeueLastObject {
	id object = [self lastObject];
	GtRetain(GtReturnAutoreleased(object));
	[self removeLastObject];
	return object;
}

- (void) pushObject:(id) object {
	[self insertObject:object atIndex:0];
}

- (id) popFirstObject {
	id object = [self objectAtIndex:0];
	GtRetain(GtReturnAutoreleased(object));
    [self removeObjectAtIndex:0];
	return object;
}
@end

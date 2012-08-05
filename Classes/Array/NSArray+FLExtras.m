//
//	FLMutableArray.m
//	FishLamp
//
//	Created by Mike Fullerton on 7/27/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "NSArray+FLExtras.h"
#import "FLAssertions.h"
#import "FLStringUtils.h"

@implementation NSArray (FLExtras)
- (NSUInteger) indexOfLastObject {
	return self.count > 0 ? self.count - 1 : NSNotFound;
}
- (id) firstObject {
	return [self objectAtIndex:0];
}
@end

@implementation NSMutableArray (FLExtras)

- (void) moveObjectToNewIndex:(NSUInteger) fromIndex toIndex:(NSUInteger) toIndex {
	FLAssert(fromIndex < (NSUInteger)self.count, @"bad from idx");
	FLAssert(toIndex < (NSUInteger)self.count, @"bad from idx");

	if(fromIndex != toIndex) {
		id object = [self objectAtIndex:fromIndex];
		FLRetain(object);
        
        [self removeObjectAtIndex:fromIndex];
		
		if(toIndex == self.count) {
			[self addObject:object];
		}
		else {
			[self insertObject:object atIndex:toIndex];
		}
		
        FLRelease(object);
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
	FLRetain(FLReturnAutoreleased(object));
	[self removeLastObject];
	return object;
}

- (void) pushObject:(id) object {
	[self insertObject:object atIndex:0];
}

- (id) popFirstObject {
	id object = [self objectAtIndex:0];
	FLRetain(FLReturnAutoreleased(object));
    [self removeObjectAtIndex:0];
	return object;
}
@end

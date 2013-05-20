//
//  GtLinkedListObjectContainer.m
//  FishLampCore
//
//  Created by Mike Fullerton on 4/24/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtLinkedListObjectContainer.h"

@implementation GtLinkedListObjectContainer

@synthesize object = _object;
@synthesize key = _key;

- (id) initWithObject:(id) object {
	if((self = [super init])) {
		self.object = object;
	}
	return self;
}

+ (GtLinkedListObjectContainer*) linkedListObjectContainer:(id) object {
    return GtReturnAutoreleased([[GtLinkedListObjectContainer alloc] initWithObject:object]);
}

#if GT_DEALLOC
- (void) dealloc {
    [_key release];
    [_object release];
	[super dealloc];
}
#endif

@end

@implementation GtLinkedList (GtLinkedListObjectContainer)

- (GtLinkedListObjectContainer*) findContainerWithObject:(id) object {
    for(GtLinkedListObjectContainer* container in self) {
        if(container.object == object) {
            return container;
        }
    }
    
    return nil;
}

- (GtLinkedListObjectContainer*) findContainerWithKey:(id) key {
    for(GtLinkedListObjectContainer* container in self) {
        if(container.key == key) {
            return container;
        }
    }
    
    return nil;
}

@end


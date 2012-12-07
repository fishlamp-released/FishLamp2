//
//  FLLinkedListObjectContainer.m
//  FLCore
//
//  Created by Mike Fullerton on 4/24/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLLinkedListObjectContainer.h"

@implementation FLLinkedListObjectContainer

@synthesize object = _object;
@synthesize key = _key;

- (id) initWithObject:(id) object {
	if((self = [super init])) {
		self.object = object;
	}
	return self;
}

+ (FLLinkedListObjectContainer*) linkedListObjectContainer:(id) object {
    return FLAutorelease([[FLLinkedListObjectContainer alloc] initWithObject:object]);
}

#if FL_MRC
- (void) dealloc {
    FLRelease(_key);
    FLRelease(_object);
	super_dealloc_();
}
#endif

@end

@implementation FLLinkedList (FLLinkedListObjectContainer)

- (FLLinkedListObjectContainer*) findContainerWithObject:(id) object {
    for(FLLinkedListObjectContainer* container in self) {
        if(container.object == object) {
            return container;
        }
    }
    
    return nil;
}

- (FLLinkedListObjectContainer*) findContainerWithKey:(id) key {
    for(FLLinkedListObjectContainer* container in self) {
        if(container.key == key) {
            return container;
        }
    }
    
    return nil;
}

@end


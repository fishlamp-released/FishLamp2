//
//  FLObjcNamedObjectCollection.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/11/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcNamedObjectCollection.h"
#import "FLObjcName.h"

@implementation FLObjcNamedObjectCollection

- (id) init {	
	self = [super init];
	if(self) {
		_names = [[NSMutableDictionary alloc] init];
        _generatedStrings = [[NSMutableDictionary alloc] init];
	}
	return self;
}

+ (id) objcNamedObjectCollection {
    return FLAutorelease([[[self class] alloc] init]);
}

#if FL_MRC
- (void) dealloc {
	[_names release];
	[_generatedStrings release];
	[super dealloc];
}
#endif

- (id) objectForKey:(NSString*) name {
    id object = [_names objectForKey:[name lowercaseString]];
    if(!object) {
        object = [_generatedStrings objectForKey:name];
    }
    return object;
}

- (void) setObject:(id) object forKey:(FLObjcName*) key {
    [_names setObject:object forKey:[key.identifierName lowercaseString]];
    [_generatedStrings setObject:object forKey:key.generatedName];
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained [])buffer count:(NSUInteger)len {
    return [_names countByEnumeratingWithState:state objects:buffer count:len];
}

- (NSEnumerator *)objectEnumerator {
    return [_names objectEnumerator];
}

- (NSArray *)allKeys {
    return [_names allKeys];
}

- (NSArray *)allValues {
    return [_names allValues];
}


@end

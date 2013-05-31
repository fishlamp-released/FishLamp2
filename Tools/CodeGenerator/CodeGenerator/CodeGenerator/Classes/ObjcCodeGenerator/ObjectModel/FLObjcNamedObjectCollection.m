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
    name = [name lowercaseString];
    id object = [_names objectForKey:name];
    if(!object) {
        NSString* key = [_generatedStrings objectForKey:name];
        if(key) {
            object = [_names objectForKey:[key lowercaseString]];
        }
    }
    return object;
}

- (void) setObject:(id) object forKey:(FLObjcName*) key {
    NSString* masterKey = [key.identifierName lowercaseString];
    [_names setObject:object forKey:masterKey];
    [_generatedStrings setObject:masterKey forKey:[key.generatedName lowercaseString]];
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

//
//  FLTypeDesc.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/15/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLTypeDesc.h"

@implementation FLTypeDesc 

@synthesize objectClass = _objectClass;
@synthesize identifier = _identifier;
@synthesize subtypes = _subtypes;
@synthesize objectEncoder = _objectEncoder;

#if FL_MRC
- (void) dealloc {
    [_objectEncoder release];
    [_subtypes release];
	[_identifier release];
	[super dealloc];
}
#endif

+ (id) typeDesc:(NSString*) identifier class:(Class) aClass {
    return FLAutorelease([[[self class] alloc] initWithIdentifier:identifier class:aClass]);
}

+ (id) typeDesc:(Class) aClass {
    return FLAutorelease([[[self class] alloc] initWithIdentifier:nil class:aClass]);
}

- (id) init {
    return [self initWithClass:nil];
}

- (id) initWithIdentifier:(NSString*) identifier class:(Class) aClass {	

    FLAssertNotNil(aClass);

	self = [super init];
	if(self) {
		self.objectClass = aClass;
        self.identifier = identifier;
        self.objectEncoder = [self.objectClass objectEncoder];
	}
	return self;
}

- (id) initWithClass:(Class) aClass {
    return [self initWithIdentifier:nil class:aClass];
}

- (FLTypeDesc*) subTypeForIdentifier:(NSString*) propertyName {
	return [_subtypes objectForKey:propertyName];
}

- (void) addSubtype:(FLTypeDesc*) subtype {
    FLAssertNotNil(subtype);
    
    if(!_subtypes) {
        _subtypes = [[NSMutableDictionary alloc] init];
    }
    
    if(subtype.objectClass) {
        [_subtypes setObject:subtype forKey:subtype.identifier];
    }
#if TRACE    
    else {
        FLLog(@"skipping property %@", property.identifier);
    }
#endif    
}

- (void) setSubtypeClass:(Class) aClass forIdentifier:(NSString*) identifier {
    [self addSubtype:[FLTypeDesc typeDesc:identifier class:aClass]];
}

- (void) setSubtypeArrayTypes:(NSArray*) arrayTypes forIdentifier:(NSString*) identifier {
    FLTypeDesc* typeDesc = [FLTypeDesc typeDesc:identifier class:[NSMutableArray class]];

    for(FLTypeDesc* desc in arrayTypes) {
        [typeDesc addSubtype:desc];
    }

    [self addSubtype:typeDesc];
}

- (NSString*) description {
	return [NSString stringWithFormat:@"%@: { class=%@, subtypes:%@", [super description], NSStringFromClass(self.objectClass), [_subtypes description]];
}



@end
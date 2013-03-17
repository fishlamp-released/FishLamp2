//
//  FLObjectDescriber.m
//  PackMule
//
//  Created by Mike Fullerton on 6/29/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLPropertyType.h"
#import "FLStringUtils.h"

@interface FLPropertyType ()
@property (readwrite, strong, nonatomic) NSString* propertyName;
@property (readwrite, strong, nonatomic) NSArray* arrayTypes;
@property (readwrite, strong, nonatomic) FLType* propertyType;
@end

@implementation FLPropertyType

@synthesize arrayTypes = _arrayTypes;
@synthesize propertyType = _propertyType;
@synthesize propertyName = _propertyName;

- (id) initWithPropertyName:(NSString*) name
              propertyClass:(Class) propertyClass
                 arrayTypes:(NSArray*) arrayTypes {

	if((self = [super init])) {
		FLAssertStringIsNotEmpty_(name);
        self.propertyName = name;
		self.propertyType = [propertyClass type];
        self.arrayTypes = arrayTypes;
	}
	
	return self;
}

- (Class) propertyClass {
    return _propertyType.classForType;
}

- (id) initWithPropertyName:(NSString*) name
              propertyClass:(Class) propertyClass {
    return [self initWithPropertyName:name propertyClass:propertyClass arrayTypes:nil];
}


+ (FLPropertyType*) propertyType:(NSString*) name
                   propertyClass:(Class) propertyClass {

	return FLAutorelease([[FLPropertyType alloc] initWithPropertyName:name propertyClass:propertyClass arrayTypes:nil]);
}


+ (FLPropertyType*) propertyType:(NSString*) name
                   propertyClass:(Class) propertyClass
                      arrayTypes:(NSArray*) arrayTypes {

	return FLAutorelease([[FLPropertyType alloc] initWithPropertyName:name propertyClass:propertyClass arrayTypes:arrayTypes]);
}

#if FL_MRC
- (void) dealloc {
    [_propertyType release];
    [_arrayTypes release];
    [_propertyName release];
    [super dealloc];
}
#endif

- (BOOL) isArray {
	return _arrayTypes.count > 0;
}	

- (NSString*) description {
	return [NSString stringWithFormat:@"%@: Name: %@, Class: %@, ArrayTypes:\n%@",
		[super description],
		self.propertyName,
		NSStringFromClass(self.propertyClass),
		[self.arrayTypes description]];
}

- (void) setPropertyValue:(id) value forObject:(id) object {
    [object setValue:value forKey:self.propertyName];
}

- (id) propertyValueForObject:(id) object {
    return [object valueForKey:self.propertyName];
}

@end



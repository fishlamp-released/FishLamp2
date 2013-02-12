//
//  FLObjectDescriber.m
//  PackMule
//
//  Created by Mike Fullerton on 6/29/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLPropertyDescription.h"
#import "FLStringUtils.h"

@interface FLPropertyDescription ()
@property (readwrite, strong, nonatomic) NSString* propertyName;
@property (readwrite, assign, nonatomic) Class propertyClass;
@property (readwrite, strong, nonatomic) FLTypeDesc* propertyType;
@property (readwrite, strong, nonatomic) NSArray* arrayTypes;
@property (readwrite, assign, nonatomic, getter=isUnboundedArray) BOOL unboundedArray;
@property (readwrite, assign, nonatomic, getter=isUnboundedArrayItem) BOOL unboundedArrayItem;

@end

@implementation FLPropertyDescription

@synthesize propertyName = _name;
@synthesize propertyClass = _class;
@synthesize arrayTypes = _arrayTypes;
@synthesize getter = _getter;
@synthesize setter = _setter;
@synthesize propertyType = _propertyType;
@synthesize unboundedArray = _unboundedArray;
@synthesize unboundedArrayItem = _unboundedArrayItem;

- (id) initWithPropertyName:(NSString*) name
              propertyClass:(Class) aClass
               propertyType:(FLTypeDesc*) dataType
                 arrayTypes:(NSArray*) arrayTypes {

	return [self initWithPropertyName:name propertyClass:aClass propertyType:dataType arrayTypes:arrayTypes isUnboundedArray:NO];
}

- (id) initWithPropertyName:(NSString*) name
              propertyClass:(Class) aClass
               propertyType:(FLTypeDesc*) dataType
                 arrayTypes:(NSArray*) arrayTypes
           isUnboundedArray:(BOOL) isUnboundedArray {
	if((self = [super init]))
	{
		FLAssertStringIsNotEmpty_(name);
	
        self.propertyName = name;
		self.propertyClass = aClass;
		self.propertyType = dataType;
		self.arrayTypes = arrayTypes;
		self.unboundedArray = isUnboundedArray;

		self.setter = NSSelectorFromString([NSString stringWithFormat:@"set%@:", [name stringWithUpperCaseFirstLetter]]);

        self.getter = NSSelectorFromString(name);
        
		if(self.isUnboundedArray) {
			for(FLPropertyDescription* desc in self.arrayTypes) {
				self.unboundedArrayItem = YES;
			}
		}
		
	}
	
	return self;
}

- (id) initWithPropertyName:(NSString*) name
              propertyClass:(Class) aClass
               propertyType:(FLTypeDesc*) dataType {

	return [self initWithPropertyName:name propertyClass:aClass propertyType:dataType arrayTypes:nil isUnboundedArray:NO];
}

+ (FLPropertyDescription*) propertyDescription:(NSString*) name
                                 propertyClass:(Class) aClass
                                  propertyType:(FLTypeDesc*) dataType {

	return FLAutorelease([[FLPropertyDescription alloc] initWithPropertyName:name propertyClass:aClass propertyType:dataType arrayTypes:nil isUnboundedArray:NO]);
}


+ (FLPropertyDescription*) propertyDescription:(NSString*) name
                                 propertyClass:(Class) aClass
                                  propertyType:(FLTypeDesc*) dataType
                                    arrayTypes:(NSArray*) arrayTypes
                              isUnboundedArray:(BOOL) isUnboundedArray {

	return FLAutorelease([[FLPropertyDescription alloc] initWithPropertyName:name propertyClass:aClass propertyType:dataType arrayTypes:arrayTypes isUnboundedArray:isUnboundedArray]);
}

+ (FLPropertyDescription*) propertyDescription:(NSString*) name
                                 propertyClass:(Class) aClass
                                  propertyType:(FLTypeDesc*) dataType
                                    arrayTypes:(NSArray*) arrayTypes {

	return FLAutorelease([[FLPropertyDescription alloc] initWithPropertyName:name propertyClass:aClass propertyType:dataType arrayTypes:arrayTypes isUnboundedArray:NO]);
}

#if FL_MRC
- (void) dealloc {
    [_arrayTypes release];
    [_name release];
    [_propertyType release];
    [super dealloc];
}
#endif

- (BOOL) isArray {
	return _arrayTypes.count > 0;
}	

- (NSString*) description {
	return [NSString stringWithFormat:@"%@: Name: %@, Class: %@, Type: %@, isUnboundedArray: %d, isUnboundedArrayType: %d, ArrayTypes:\n%@",
		[super description],
		self.propertyName,
		NSStringFromClass(self.propertyClass),
		[self.propertyType description],
		self.isUnboundedArray,
		self.isUnboundedArrayItem,
		[self.arrayTypes description]];
}
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Warc-performSelector-leaks"

- (void) setPropertyValue:(id) value forObject:(id) object {
    [object performSelector:self.setter withObject:value];
}

- (id) propertyValueForObject:(id) object {
    return [object performSelector:self.getter];
}

#pragma GCC diagnostic pop



@end

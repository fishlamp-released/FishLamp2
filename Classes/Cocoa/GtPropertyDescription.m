//
//  GtObjectDescriber.m
//  PackMule
//
//  Created by Mike Fullerton on 6/29/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtPropertyDescription.h"

@interface GtPropertyDescription ()
@property (readwrite, retain, nonatomic) NSString* propertyName;
@property (readwrite, assign, nonatomic) Class propertyClass;
@property (readwrite, assign, nonatomic) GtDataTypeID propertyType;
@property (readwrite, retain, nonatomic) NSArray* arrayTypes;
@end

@implementation GtPropertyDescription

@synthesize propertyName = m_name;
@synthesize propertyClass = m_class;
@synthesize arrayTypes = m_arrayTypes;

GtSynthesizeStructProperty(propertyType, setPropertyType, GtDataTypeID, m_flags);
GtSynthesizeStructProperty(isUnboundedArray, setUnboundedArray, BOOL, m_flags);
GtSynthesizeStructProperty(isUnboundedArrayItem, setUnboundedArrayItem, BOOL, m_flags);

- (id) initWithPropertyName:(NSString*) name
	propertyClass:(Class) aClass
	propertyType:(GtDataTypeID) dataType
	arrayTypes:(NSArray*) arrayTypes
{
	return [self initWithPropertyName:name propertyClass:aClass propertyType:dataType arrayTypes:arrayTypes isUnboundedArray:NO];
}

- (id) initWithPropertyName:(NSString*) name
	propertyClass:(Class) aClass
	propertyType:(GtDataTypeID) dataType
	arrayTypes:(NSArray*) arrayTypes
	isUnboundedArray:(BOOL) isUnboundedArray;
{
	if((self = [super init]))
	{
		GtAssertIsValidString(name);
	
		self.propertyName = name;
		self.propertyClass = aClass;
		self.propertyType = dataType;
		self.arrayTypes = arrayTypes;
		self.unboundedArray = isUnboundedArray;
		
		if(self.isUnboundedArray)
		{
			for(GtPropertyDescription* desc in self.arrayTypes)
			{
				desc.unboundedArrayItem = YES;
			}
		}
		
	}
	
	return self;
}

- (id) initWithPropertyName:(NSString*) name
	propertyClass:(Class) aClass
	propertyType:(GtDataTypeID) dataType
{
	return [self initWithPropertyName:name propertyClass:aClass propertyType:dataType arrayTypes:nil isUnboundedArray:NO];
}

+ (GtPropertyDescription*) propertyDescription:(NSString*) name
	propertyClass:(Class) aClass
	propertyType:(GtDataTypeID) dataType
{
	return GtReturnAutoreleased([[GtPropertyDescription alloc] initWithPropertyName:name propertyClass:aClass propertyType:dataType arrayTypes:nil isUnboundedArray:NO]);
}


+ (GtPropertyDescription*) propertyDescription:(NSString*) name
	propertyClass:(Class) aClass
	propertyType:(GtDataTypeID) dataType
	arrayTypes:(NSArray*) arrayTypes
	isUnboundedArray:(BOOL) isUnboundedArray
{
	return GtReturnAutoreleased([[GtPropertyDescription alloc] initWithPropertyName:name propertyClass:aClass propertyType:dataType arrayTypes:arrayTypes isUnboundedArray:isUnboundedArray]);
}

+ (GtPropertyDescription*) propertyDescription:(NSString*) name
	propertyClass:(Class) aClass
	propertyType:(GtDataTypeID) dataType
	arrayTypes:(NSArray*) arrayTypes
{
	return GtReturnAutoreleased([[GtPropertyDescription alloc] initWithPropertyName:name propertyClass:aClass propertyType:dataType arrayTypes:arrayTypes isUnboundedArray:NO]);
}


- (void) dealloc
{
	GtRelease(m_arrayTypes);
	GtRelease(m_name);
	GtSuperDealloc();
}

- (BOOL) isArray
{
	return m_arrayTypes.count > 0;
}	

- (NSString*) description
{
	return [NSString stringWithFormat:@"%@: Name: %@, Class: %@, Type: %d, isUnboundedArray: %d, isUnboundedArrayType: %d, ArrayTypes:\n%@",
		[super description],
		self.propertyName,
		NSStringFromClass(self.propertyClass),
		self.propertyType,
		self.isUnboundedArray,
		self.isUnboundedArrayItem,
		[self.arrayTypes description]];

}


@end

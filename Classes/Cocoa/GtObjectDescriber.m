//
//  GtObjectDescriber.m
//  PackMule
//
//  Created by Mike Fullerton on 6/30/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtObjectDescriber.h"

//#import "GtObjcRuntime.h"

#import <objc/runtime.h>

@interface GtObjectDescriber ()
@property (readwrite, copy, nonatomic) NSDictionary* propertyDescribers;
@end

@implementation GtObjectDescriber

@synthesize propertyDescribers = m_propertyDescribers;

- (id) init
{
	if((self = [super init]))
	{
		m_propertyDescribers = [[NSMutableDictionary alloc] init];
	}
	
	return self;
}

- (id) initWithPropertyDescribers:(NSDictionary*) describers
{
	if((self = [super init]))
	{
		m_propertyDescribers = [[NSMutableDictionary alloc] init];
		for(GtPropertyDescription* prop in describers.objectEnumerator)
		{
			[self setPropertyDescriber:prop forPropertyName:prop.propertyName];
		}
	}
	
	return self;
}

- (id) _initWithDictionaryForCopy:(NSDictionary*) dictionary
{
	if((self = [super init]))
	{
		m_propertyDescribers = [dictionary mutableCopy];
	}
	
	return self;
}

- (void) dealloc
{
	GtRelease(m_propertyDescribers);
	GtSuperDealloc();
}

- (id) copyWithZone:(NSZone *)zone
{
	GtObjectDescriber* desc = [[GtObjectDescriber alloc] _initWithDictionaryForCopy:self.propertyDescribers];
	return desc;
}

- (void) setPropertyDescriber:(GtPropertyDescription*) objectDescriber forPropertyName:(NSString*) propertyName;
{
	[m_propertyDescribers setObject:objectDescriber forKey:propertyName];
	
	if(objectDescriber.isUnboundedArray)
	{
		for(GtPropertyDescription* prop in objectDescriber.arrayTypes)
		{
			GtAssertNil([m_propertyDescribers objectForKey:prop.propertyName]);
			[m_propertyDescribers setObject:prop forKey:prop.propertyName];
		}
	}
}

- (GtPropertyDescription*) propertyDescriberForPropertyName:(NSString*) propertyName
{
	return [m_propertyDescribers objectForKey:propertyName];
	
}

//- (void) addPropertiesForClass:(Class) class
//{
//	if(class == [NSObject class])
//	{
//		return;
//	}
//
//	Class superclass = class_getSuperclass(class);
//	if(superclass)
//	{
//		[self addPropertiesForClass:superclass];
//	}
//
//	unsigned int propertyCount = 0;
//	objc_property_t* properties = class_copyPropertyList(class, &propertyCount);
//
//	for(unsigned int i = 0; i < propertyCount; i++)
//	{
//		char* className = copyTypeNameFromProperty(properties[i]);
//	//	printf("name: %s, attributes %s\n",name, attributes);
//		
//		if(className)
//		{
//			Class c = objc_getClass(className);
//			
//			GtAssertNotNil(c);
//			   
//			NSString* propertyName = [NSString stringWithCString:property_getName(properties[i]) encoding:NSASCIIStringEncoding];
//			
//			[self setPropertyDescriber:[GtPropertyDescription propertyDescription:propertyName
//				propertyClass:c
//				propertyType:GtDataTypeUnknown
//				arrayTypes:nil] forPropertyName:propertyName];
//							 
//			free(className);
//	
//		//	printf("\tname: %s, value: '%s'\n", attrList[j].name, attrList[j].value);
//		}
//		
//	}
//
//
//	free(properties);
//}

- (NSString*) description
{
	return [NSString stringWithFormat:@"%@:%@", [super description], [m_propertyDescribers description]];
}

@end

@implementation NSObject (GtObjectDescriber)

+ (GtObjectDescriber*) sharedObjectDescriber
{
	return nil;
}

@end


typedef void (*CompareCallback) (id, id, GtMergeMode, NSArray* arrayItemTypes); 

void _GtMergeListsOfObjects(
	NSMutableArray* dest, 
	NSArray* src, 
	GtMergeMode mergeMode, 
	NSArray* arrayItemTypes,
	CompareCallback handleEqual)
{
	for(NSInteger i = (NSInteger) src.count - 1; i >= 0; i--)
	{	
		id outer = [src objectAtIndex:i];
		bool foundIt = NO;
		for(NSInteger j = (NSInteger) dest.count - 1; j >= 0; j--)
		{
			id inner = [dest objectAtIndex:j];
			if([inner isEqual:outer])
			{	
				handleEqual(inner, outer, mergeMode, arrayItemTypes);
				foundIt = YES;
				break;
			}
		}
		if(!foundIt)
		{
			[dest addObject:outer];
		}
	}
}

void GtEqualObjectHandler(id inner, id outer, GtMergeMode mergeMode, NSArray* arrayItemTypes)
{
	GtMergeObjects(inner, outer, mergeMode); 
}

void GtEqualValueHandler(id inner, id outer, GtMergeMode mergeMode, NSArray* arrayItemTypes)
{
	// already equal, so nothing to do.
}

void GtEqualMultiObjectHandler(id inner, id outer, GtMergeMode mergeMode, NSArray* arrayItemTypes)
{
	for(GtPropertyDescription* desc in arrayItemTypes)
	{
		if([outer isKindOfClass:desc.propertyClass] && desc.propertyType == GtDataTypeObject)
		{
			GtMergeObjects(inner, outer, mergeMode); 
			
			break;
		}
	}
	

//	GtDataTypeStruct* itemType = GtGetTypeForClass(arrayItemTypes, [outer class]);
//	if(itemType && itemType->typeID == GtDataTypeObject)
//	{
//		GtMergeObjects(inner, outer, mergeMode); 
//	}
}

void GtMergeObjectArrays(NSMutableArray* dest, NSArray* src, GtMergeMode mergeMode, NSArray* arrayItemTypes)
{
	if(arrayItemTypes.count)
	{
		if([[arrayItemTypes firstObject] propertyType] == GtDataTypeObject)
		{
			_GtMergeListsOfObjects(dest, src, mergeMode, arrayItemTypes, GtEqualObjectHandler);
		}
		else
		{
			_GtMergeListsOfObjects(dest, src, mergeMode, arrayItemTypes, GtEqualValueHandler);
		}
	}
	else
	{
		_GtMergeListsOfObjects(dest, src, mergeMode, arrayItemTypes, GtEqualMultiObjectHandler);
	}
}

void GtMergeObjects(id dest, id src, GtMergeMode mergeMode)
{
	if(dest && src)
	{
		GtAssert([dest isKindOfClass:[src class]], @"objects are different classes");

		GtObjectDescriber* srcDescriber = [[src class] sharedObjectDescriber];
		for(NSString* srcPropName in srcDescriber.propertyDescribers)
		{
			id srcObject = [src valueForKey:srcPropName];
			if(srcObject)
			{
				id destObject =	[dest valueForKey:srcPropName];
				if(!destObject)
				{
					[dest setValue:srcObject forKey:srcPropName];
				}
				else
				{
					GtPropertyDescription* srcProp = [srcDescriber propertyDescriberForPropertyName:srcPropName];
					if(srcProp.propertyType != GtDataTypeObject)
					{
					   if(mergeMode == GtMergeModeSourceWins)
					   {
							[dest setValue:srcObject forKey:srcPropName];
					   }
					}
					else if(srcProp.arrayTypes.count > 0)
					{
						GtMergeObjectArrays(destObject, srcObject, mergeMode, srcProp.arrayTypes);
					}
					else 
					{
						GtMergeObjects(destObject, srcObject, mergeMode);
					}
				}
			}
		}
	}
}

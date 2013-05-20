//
//  NSObject+JsonParser.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/17/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "NSObject+JsonParser.h"
#import "GtDateMgr.h"
#import "GtObjectDescriber.h"
#import "GtDataTypeID.h"

@implementation NSObject (GtJsonParser)

- (BOOL) openJsonObjectForKey:(NSString *)key 
	parentKey:(NSString*) parentKey
	parentObject:(id) parentObject 
	outObject:(id*) outObject
{
	GtAssertIsValidString(key);

	GtObjectDescriber* describer = [[self class] sharedObjectDescriber];
	GtAssertNotNil(describer);

	GtPropertyDescription* desc = [describer propertyDescriberForPropertyName:key];
//	GtAssertNotNil(desc);

	if(desc)
	{
		GtAssert(desc.propertyType == GtDataTypeObject, @"opening object thats a simple type");
		if(desc.propertyType == GtDataTypeObject)
		{
			id newObject = [self valueForKey:key];
			if(!newObject)
			{
				newObject = GtReturnAutoreleased([[desc.propertyClass alloc] init]);
				[self setValue:newObject forKey:key];
			}
		
			GtAssertNotNil(newObject);
			if(outObject)
			{
				*outObject = GtRetain(newObject);
			}
			
			return YES;
		}
	}

	GtLog(@"Warning: unable to open object: %@.%@.%@", NSStringFromClass([parentObject class]), parentKey, key);
	if(outObject)
	{
		*outObject = GtRetain([NSNull null]);
	}
	
	return NO;
}
- (BOOL) setJsonData:(id) data forKey:(NSString*) key
{
	GtAssertIsValidString(key);

	GtObjectDescriber* describer = [[self class] sharedObjectDescriber];
	GtAssertNotNil(describer);

	GtPropertyDescription* desc = [describer propertyDescriberForPropertyName:key];
//	GtAssertNotNil(desc);

	if(desc)
	{
		switch(desc.propertyType)
		{
			case GtDataTypeDate:
			{
				data = [[GtDateMgr instance] ISO3339StringToDate:data];
			}
			break;
			
			default:
			break;
		}
	
		[self setValue:data forKey:key];
		
		return YES;
	}

	GtLog(@"Warning: data not set for key:%@.%@. Data: %@", NSStringFromClass([self class]), key, [data description]);
	return NO;
}

@end

@implementation NSMutableArray (GtJsonParser)

- (BOOL) openJsonObjectForKey:(NSString *) arrayItemKey 
	parentKey:(NSString*) parentPropertyKey
	parentObject:(id) parentObject 
	outObject:(id*) outObject
{
	GtAssertIsValidString(arrayItemKey);


	GtObjectDescriber* describer = [[parentObject class] sharedObjectDescriber];
	GtAssertNotNil(describer);

	GtPropertyDescription* desc = [describer propertyDescriberForPropertyName:arrayItemKey];
	GtAssertNotNil(desc);
	
	if(desc)
	{
		for(GtPropertyDescription* property in desc.arrayTypes)
		{
		//	if(GtStringsAreEqual(property.propertyName, arrayItemKey))
			{
				if(property.propertyType == GtDataTypeObject)
				{
					GtAssertNotNil(property.propertyClass);

					id obj = [[property.propertyClass alloc] init];
					GtAssert(obj != nil, @"Unable to created object of type: %@", NSStringFromClass(property.propertyClass));

					GtAssertNotNil(obj);
					[self addObject:obj];
					GtRelease(obj);
					
					if(outObject)
					{
						*outObject = GtRetain(obj);
					}
				}
				else
				{
					if(outObject)
					{
						*outObject = GtRetain(self);
					}
				}
				
				return YES;	
			}
		}
	}
	
	GtLog(@"Warning: unable to open array object: %@.%@.%@", NSStringFromClass([parentObject class]), parentPropertyKey, arrayItemKey);
	
	if(outObject)
	{
		*outObject = GtRetain([NSNull null]);
	}
	
	return NO;
}

- (BOOL) setJsonData:(id) data forKey:(NSString*) key
{
	[self addObject:data];
	return YES;
}

@end

@implementation NSNull (GtJsonParser)

- (BOOL) openJsonObjectForKey:(NSString *)key 
	parentKey:(NSString*) parentKey
	parentObject:(id) parentObject 
	outObject:(id*) outObject
{
	// no-op
	
	if(outObject)
	{
		*outObject = GtRetain(self);
	}
	
	GtLog(@"opening data for NSNull failed by design");
	
	return YES;
}
@end

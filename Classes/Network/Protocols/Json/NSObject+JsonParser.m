//
//  NSObject+JsonParser.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/17/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "NSObject+JsonParser.h"
#import "FLDateMgr.h"
#import "FLObjectDescriber.h"
#import "FLDataTypeID.h"

@implementation NSObject (FLJsonParser)

- (BOOL) openJsonObjectForKey:(NSString *)key 
	parentKey:(NSString*) parentKey
	parentObject:(id) parentObject 
	outObject:(id*) outObject
{
	FLAssertStringIsNotEmpty_(key);

	FLObjectDescriber* describer = [[self class] sharedObjectDescriber];
	FLAssertIsNotNil_(describer);

	FLPropertyDescription* desc = [describer propertyDescriberForPropertyName:key];
//	FLAssertIsNotNil_(desc);

	if(desc)
	{
		FLAssert_v(desc.propertyType == FLDataTypeObject, @"opening object thats a simple type");
		if(desc.propertyType == FLDataTypeObject)
		{
			id newObject = [self valueForKey:key];
			if(!newObject)
			{
				newObject = autorelease_([[desc.propertyClass alloc] init]);
				[self setValue:newObject forKey:key];
			}
		
			FLAssertIsNotNil_(newObject);
			if(outObject)
			{
				*outObject = retain_(newObject);
			}
			
			return YES;
		}
	}

	FLDebugLog(@"Warning: unable to open object: %@.%@.%@", NSStringFromClass([parentObject class]), parentKey, key);
	if(outObject)
	{
		*outObject = retain_([NSNull null]);
	}
	
	return NO;
}
- (BOOL) setJsonData:(id) data forKey:(NSString*) key
{
	FLAssertStringIsNotEmpty_(key);

	FLObjectDescriber* describer = [[self class] sharedObjectDescriber];
	FLAssertIsNotNil_(describer);

	FLPropertyDescription* desc = [describer propertyDescriberForPropertyName:key];
//	FLAssertIsNotNil_(desc);

	if(desc)
	{
		switch(desc.propertyType)
		{
			case FLDataTypeDate:
			{
				data = [[FLDateMgr instance] ISO3339StringToDate:data];
			}
			break;
			
			default:
			break;
		}
	
		[self setValue:data forKey:key];
		
		return YES;
	}

	FLDebugLog(@"Warning: data not set for key:%@.%@. Data: %@", NSStringFromClass([self class]), key, [data description]);
	return NO;
}

@end

@implementation NSMutableArray (FLJsonParser)

- (BOOL) openJsonObjectForKey:(NSString *) arrayItemKey 
	parentKey:(NSString*) parentPropertyKey
	parentObject:(id) parentObject 
	outObject:(id*) outObject
{
	FLAssertStringIsNotEmpty_(arrayItemKey);


	FLObjectDescriber* describer = [[parentObject class] sharedObjectDescriber];
	FLAssertIsNotNil_(describer);

	FLPropertyDescription* desc = [describer propertyDescriberForPropertyName:arrayItemKey];
	FLAssertIsNotNil_(desc);
	
	if(desc)
	{
		for(FLPropertyDescription* property in desc.arrayTypes)
		{
		//	if(FLStringsAreEqual(property.propertyName, arrayItemKey))
			{
				if(property.propertyType == FLDataTypeObject)
				{
					FLAssertIsNotNil_(property.propertyClass);

					id obj = [[property.propertyClass alloc] init];
					FLAssert_v(obj != nil, @"Unable to created object of type: %@", NSStringFromClass(property.propertyClass));

					FLAssertIsNotNil_(obj);
					[self addObject:obj];
					mrc_release_(obj);
					
					if(outObject)
					{
						*outObject = retain_(obj);
					}
				}
				else
				{
					if(outObject)
					{
						*outObject = retain_(self);
					}
				}
				
				return YES;	
			}
		}
	}
	
	FLDebugLog(@"Warning: unable to open array object: %@.%@.%@", NSStringFromClass([parentObject class]), parentPropertyKey, arrayItemKey);
	
	if(outObject)
	{
		*outObject = retain_([NSNull null]);
	}
	
	return NO;
}

- (BOOL) setJsonData:(id) data forKey:(NSString*) key
{
	[self addObject:data];
	return YES;
}

@end

@implementation NSNull (FLJsonParser)

- (BOOL) openJsonObjectForKey:(NSString *)key 
	parentKey:(NSString*) parentKey
	parentObject:(id) parentObject 
	outObject:(id*) outObject
{
	// no-op
	
	if(outObject)
	{
		*outObject = retain_(self);
	}
	
	FLDebugLog(@"opening data for NSNull failed by design");
	
	return YES;
}
@end

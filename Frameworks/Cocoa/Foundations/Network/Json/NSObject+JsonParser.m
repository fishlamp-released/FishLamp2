//
//  NSObject+JsonParser.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/17/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#if REFACTOR

#import "NSObject+JsonParser.h"
#import "FLDateMgr.h"
#import "FLObjectDescriber.h"
#import "FLType.h"

@implementation NSObject (FLJsonParser)

- (BOOL) openJsonObjectForKey:(NSString *)key 
	parentKey:(NSString*) parentKey
	parentObject:(id) parentObject 
	outObject:(id*) outObject
{
//	FLAssertStringIsNotEmpty_(key);
//
//	FLObjectDescriber* describer = [[self class] sharedObjectDescriber];
//	FLAssertIsNotNil_(describer);
//
//	FLPropertyType* desc = [describer propertyForName:key];
////	FLAssertIsNotNil_(desc);
//
//	if(desc)
//	{
//		FLAssert_v(desc.propertyType.isObject, @"opening object thats a simple type");
//		if(FLDataTypeIsObject(desc.propertyType))
//		{
//			id newObject = [self valueForKey:key];
//			if(!newObject)
//			{
//				newObject = FLAutorelease([[desc.propertyType.classForType alloc] init]);
//				[self setValue:newObject forKey:key];
//			}
//		
//			FLAssertIsNotNil_(newObject);
//			if(outObject)
//			{
//				*outObject = FLRetain(newObject);
//			}
//			
//			return YES;
//		}
//	}
//
//	FLDebugLog(@"Warning: unable to open object: %@.%@.%@", NSStringFromClass([parentObject class]), parentKey, key);
//	if(outObject)
//	{
//		*outObject = FLRetain([NSNull null]);
//	}
	
	return NO;
}
- (BOOL) setJsonData:(id) data forKey:(NSString*) key
{
//	FLAssertStringIsNotEmpty_(key);
//
//	FLObjectDescriber* describer = [[self class] sharedObjectDescriber];
//	FLAssertIsNotNil_(describer);
//
//	FLPropertyType* desc = [describer propertyForName:key];
////	FLAssertIsNotNil_(desc);
//
//	if(desc) {
//		switch(desc.propertyType.specificType) {
//			case FLSpecificTypeDate: {
//				data = [[FLDateMgr instance] ISO3339StringToDate:data];
//			}
//			break;
//			
//			default:
//			break;
//		}
//	
//		[self setValue:data forKey:key];
//		
//		return YES;
//	}
//
//	FLDebugLog(@"Warning: data not set for key:%@.%@. Data: %@", NSStringFromClass([self class]), key, [data description]);
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

	FLPropertyType* desc = [describer propertyForName:arrayItemKey];
	FLAssertIsNotNil_(desc);
	
	if(desc)
	{
		for(FLPropertyType* property in desc.arrayTypes)
		{
		//	if(FLStringsAreEqual(property.propertyName, arrayItemKey))
			{
                FLAssertIsNotNil_(property.propertyType.classForType);
                FLObjectDescriber* propDescriber = [property.propertyType.classForType sharedObjectDescriber];
            
				if(propDescriber)
				{
					
					id obj = [[property.propertyType.classForType alloc] init];
					FLAssert_v(obj != nil, @"Unable to created object of type: %@", NSStringFromClass(property.propertyType.classForType));

					FLAssertIsNotNil_(obj);
					[self addObject:obj];
					FLRelease(obj);
					
					if(outObject)
					{
						*outObject = FLRetain(obj);
					}
				}
				else
				{
					if(outObject)
					{
						*outObject = FLRetain(self);
					}
				}
				
				return YES;	
			}
		}
	}
	
	FLDebugLog(@"Warning: unable to open array object: %@.%@.%@", NSStringFromClass([parentObject class]), parentPropertyKey, arrayItemKey);
	
	if(outObject)
	{
		*outObject = FLRetain([NSNull null]);
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
		*outObject = FLRetain(self);
	}
	
	FLDebugLog(@"opening data for NSNull failed by design");
	
	return YES;
}
@end

#endif
//
//  FLObjectBuilder.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/9/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLObjectBuilder.h"
#import "FLObjectDescriber.h"
#import "FLDateMgr.h"

@interface FLObjectBuilder ()
- (void) buildObject:(id) object fromDictionary:(NSDictionary*) dictionary withObjectDescriber:(FLObjectDescriber*) describer;
- (NSMutableArray*) addObjectsToArray:(NSMutableArray*) fromArray 
	forProperty:(FLPropertyDescription*) propertyDescription;
@end

@implementation FLObjectBuilder

- (NSMutableArray*) addObjectsToArray:(NSMutableArray*) fromArray 
	forProperty:(FLPropertyDescription*) propertyDescription
{
	NSMutableArray* newArray = [NSMutableArray arrayWithCapacity:[fromArray count]];
	
	FLPropertyDescription* arrayItemDesc = [[propertyDescription arrayTypes] objectAtIndex:0];
		
	for(id arrayItem in fromArray)
	{			
		if([arrayItem isKindOfClass:[NSDictionary class]])
		{
			id newObject = autorelease_([[arrayItemDesc.propertyClass alloc] init]);
			[newArray addObject:newObject];
			[self buildObject:newObject fromDictionary:arrayItem withObjectDescriber:[[newObject class] sharedObjectDescriber]];
		}
//		else if([value isKindOfClass:[NSArray class]])
//		{
//			[newArray addObject:[self addObjectsToArray:value forProperty:prop] forKey:prop.propertyName];
//		}
		else
		{
			switch(arrayItemDesc.propertyType)
			{
				case FLDataTypeDate:
					[newArray addObject: [[FLDateMgr instance] ISO8601StringToDate:arrayItem]];
				break;
				
				default:
                    [newArray addObject:arrayItem];
				break;
			}
		}
	}
	
	return newArray;
}

- (void) buildObject:(id) object fromDictionary:(NSDictionary*) dictionary withObjectDescriber:(FLObjectDescriber*) describer
{
	for(NSString* key in dictionary)
	{
		id value = [dictionary objectForKey:key];
		if(value)
		{
			FLPropertyDescription* property = [describer.propertyDescribers objectForKey:key];
			if(property)
			{
				if([value isKindOfClass:[NSDictionary class]])
				{
					FLAssert_v(property.propertyType == FLDataTypeObject, @"not an object?");
				
					id newObject = autorelease_([[property.propertyClass alloc] init]);
					[object setValue:newObject forKey:key];
					[self buildObject:newObject fromDictionary:value withObjectDescriber:[[newObject class] sharedObjectDescriber]];
				}
				else if([value isKindOfClass:[NSArray class]])
				{
					[object setValue:[self addObjectsToArray:value forProperty:property] forKey:key];
				}
				else
				{
					switch(property.propertyType)
					{
						case FLDataTypeDate:
							value = [[FLDateMgr instance] ISO8601StringToDate:value];
						break;
						
						default:
						break;
					}
					
					[object setValue:value forKey:key];
				}
			}
			else
			{
				FLDebugLog(@"Warning: unknown property for key: %@, value: %@", key, [value description]);
			}
		}
	}
}


- (void) buildObjectsFromDictionary:(NSDictionary*) dictionary withRootObject:(id) rootObject
{
	[self buildObject:rootObject fromDictionary:dictionary withObjectDescriber:[[rootObject class] sharedObjectDescriber]];
}
	
@end

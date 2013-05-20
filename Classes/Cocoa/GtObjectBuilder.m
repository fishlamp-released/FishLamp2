//
//  GtObjectBuilder.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/9/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtObjectBuilder.h"
#import "GtObjectDescriber.h"
#import "GtDateMgr.h"

@interface GtObjectBuilder ()
- (void) buildObject:(id) object fromDictionary:(NSDictionary*) dictionary withObjectDescriber:(GtObjectDescriber*) describer;
- (NSMutableArray*) addObjectsToArray:(NSMutableArray*) fromArray 
	forProperty:(GtPropertyDescription*) propertyDescription;
@end

@implementation GtObjectBuilder

- (NSMutableArray*) addObjectsToArray:(NSMutableArray*) fromArray 
	forProperty:(GtPropertyDescription*) propertyDescription
{
	NSMutableArray* newArray = [NSMutableArray arrayWithCapacity:[fromArray count]];
	
	GtPropertyDescription* arrayItemDesc = [[propertyDescription arrayTypes] objectAtIndex:0];
		
	for(id arrayItem in fromArray)
	{			
		if([arrayItem isKindOfClass:[NSDictionary class]])
		{
			id newObject = GtReturnAutoreleased([[arrayItemDesc.propertyClass alloc] init]);
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
				case GtDataTypeDate:
					arrayItem = [[GtDateMgr instance] ISO8601StringToDate:arrayItem];
				break;
				
				default:
				break;
			}
		
			[newArray addObject:arrayItem];
		}
	}
	
	return newArray;
}

- (void) buildObject:(id) object fromDictionary:(NSDictionary*) dictionary withObjectDescriber:(GtObjectDescriber*) describer
{
	for(NSString* key in dictionary)
	{
		id value = [dictionary objectForKey:key];
		if(value)
		{
			GtPropertyDescription* property = [describer.propertyDescribers objectForKey:key];
			if(property)
			{
				if([value isKindOfClass:[NSDictionary class]])
				{
					GtAssert(property.propertyType == GtDataTypeObject, @"not an object?");
				
					id newObject = GtReturnAutoreleased([[property.propertyClass alloc] init]);
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
						case GtDataTypeDate:
							value = [[GtDateMgr instance] ISO8601StringToDate:value];
						break;
						
						default:
						break;
					}
					
					[object setValue:value forKey:key];
				}
			}
			else
			{
				GtLog(@"Warning: unknown property for key: %@, value: %@", key, [value description]);
			}
		}
	}
}


- (void) buildObjectsFromDictionary:(NSDictionary*) dictionary withRootObject:(id) rootObject
{
	[self buildObject:rootObject fromDictionary:dictionary withObjectDescriber:[[rootObject class] sharedObjectDescriber]];
}
	
@end

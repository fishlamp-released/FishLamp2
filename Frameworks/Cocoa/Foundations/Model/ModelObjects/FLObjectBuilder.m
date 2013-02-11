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
- (void) buildObject:(id) object 
      fromDictionary:(NSDictionary*) dictionary 
 withObjectDescriber:(FLObjectDescriber*) describer
         withDecoder:(id<FLDataDecoding>) decoder;

- (NSMutableArray*) addObjectsToArray:(NSMutableArray*) fromArray 
                          forProperty:(FLPropertyDescription*) propertyDescription
                          withDecoder:(id<FLDataDecoding>) decoder;
@end

@implementation FLObjectBuilder

+ (id) objectBuilder {
    return FLAutorelease([[[self class] alloc] init]);
}

- (NSMutableArray*) addObjectsToArray:(NSMutableArray*) fromArray 
	forProperty:(FLPropertyDescription*) propertyDescription
                              withDecoder:(id<FLDataDecoding>) decoder
{
	NSMutableArray* newArray = [NSMutableArray arrayWithCapacity:[fromArray count]];
	
	FLPropertyDescription* arrayItemDesc = [[propertyDescription arrayTypes] objectAtIndex:0];
		
	for(id arrayItem in fromArray)
	{			
		if([arrayItem isKindOfClass:[NSDictionary class]])
		{
			id newObject = FLAutorelease([[arrayItemDesc.propertyClass alloc] init]);
			[newArray addObject:newObject];
			[self buildObject:newObject fromDictionary:arrayItem withObjectDescriber:[[newObject class] sharedObjectDescriber] withDecoder:decoder];
		}
		else if([arrayItem isKindOfClass:[NSArray class]]) {
			[newArray addObject:[self addObjectsToArray:arrayItem forProperty:arrayItemDesc withDecoder:decoder]];
		}
		else
		{
            if(decoder) {
                [newArray addObject:[arrayItemDesc.propertyType stringToObject:arrayItem withDecoder:decoder]];
            }
            else {
                [newArray addObject:arrayItem];
            }


//			switch(arrayItemDesc.propertyType.specificType)
//			{
//				case FLSpecificTypeDate:
//					[newArray addObject: [[FLDateMgr instance] ISO8601StringToDate:arrayItem]];
//				break;
//				
//				default:
//                    [newArray addObject:arrayItem];
//				break;
//			}

            


		}
	}
	
	return newArray;
}

- (void) buildObject:(id) object 
      fromDictionary:(NSDictionary*) dictionary 
 withObjectDescriber:(FLObjectDescriber*) describer
         withDecoder:(id<FLDataDecoding>) decoder
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
//					FLAssert_v(property.propertyType.generalType == FLGeneralTypeObject, @"not an object?");
				
					id newObject = FLAutorelease([[property.propertyClass alloc] init]);
					[object setValue:newObject forKey:key];
					[self buildObject:newObject fromDictionary:value withObjectDescriber:[[newObject class] sharedObjectDescriber] withDecoder:decoder];
				}
				else if([value isKindOfClass:[NSArray class]]) {
					[object setValue:[self addObjectsToArray:value forProperty:property withDecoder:decoder] forKey:key];
				}
				else {

                    if(decoder) {
                        value = [property.propertyType stringToObject:value withDecoder:decoder];
                    }
                
//					switch(property.propertyType.specificType)
//					{
//						case FLSpecificTypeDate:
//							value = [[FLDateMgr instance] ISO8601StringToDate:value];
//						break;
//						
//						default:
//						break;
//					}
					
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


- (void) buildObjectsFromDictionary:(NSDictionary*) dictionary 
                     withRootObject:(id) rootObject
                        withDecoder:(id<FLDataDecoding>) decoder {
	[self buildObject:rootObject fromDictionary:dictionary withObjectDescriber:[[rootObject class] sharedObjectDescriber] withDecoder:decoder];
}
	
@end

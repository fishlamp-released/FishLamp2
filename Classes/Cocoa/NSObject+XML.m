//
//  NSObject+XML.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/30/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "NSObject+XML.h"
#import "GtObjectInflator.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflatorState.h"
#import "GtXmlParser.h"

@implementation NSObject (XML)

- (void) streamSelfToXmlBuilder:(GtXmlBuilder*) builder propertyDescription:(GtPropertyDescription*) description
{
	GtObjectDescriber* objectDescriber = [[self class] sharedObjectDescriber];
	
	for(NSString* key in objectDescriber.propertyDescribers)
	{
		id object = [self valueForKey:key];
		if(object)
		{
			GtPropertyDescription* desc = [objectDescriber propertyDescriberForPropertyName:key];
		
			[builder openElement:key];

			if(desc.propertyType == GtDataTypeObject)
			{
				[object streamSelfToXmlBuilder:builder propertyDescription:desc];
			}
			else
			{
				[builder addElementValueWithObject:object propertyDescription:desc];
			}
			
			[builder closeElement];
			
		}
		
	
	}
}

- (void) finishParsingFrom:(GtXmlParser*) parser state:(GtObjectInflatorState*) state;
{
	@try
	{
		[self setValue:state.data forKey:state.key];
	}
	@catch(NSException* ex)
	{
		GtLog(@"unable to set value for %@: %@: %@", state.key, state.data, [ex description]);
	}
}

- (BOOL) beginParsingFrom:(GtXmlParser*) parser state:(GtObjectInflatorState*) state;
{
#if NEW_PARSER
	GtPropertyDescription* prop = [state.objectDescriber propertyDescriberForPropertyName:state.key];
	if(prop)
	{
		state.parsedDataType = prop.propertyType;
	
	
		if(prop.propertyType == GtDataTypeObject)
		{
			id inflator = [self objectInflator];
			
			id object = [[inflator valueForKey:state.key forObject:self] retain];
			if(!object)
			{
				GtAssertNotNil(prop.propertyClass);

				object = [[prop.propertyClass alloc] init];
				[inflator setValue:object forKey:state.key forObject:self];
			}
		
			GtAssertNotNil(object);
		
			state.object = object;
			GtRelease(object);
		}
		
		return YES;
	}
#endif
	
	return NO;
}

+ (id) objectWithContentsOfFile:(NSString*) path
{
    NSError* error = nil;
    NSData* data = [NSData dataWithContentsOfFile:path options:NSDataReadingUncached error:&error];
    if(error)
    {
        GtThrowError(GtReturnAutoreleased(error));
    }

    GtXmlParser* parser = GtReturnAutoreleased([[GtXmlParser alloc] initWithXmlData:data]);
    
    id obj = GtReturnAutoreleased([[[self class] alloc] init]);
    
    [parser buildObjects:obj];
    
    return obj;
}

@end


@implementation NSArray (XML)

- (void) streamSelfToXmlBuilder:(GtXmlBuilder*) builder propertyDescription:(GtPropertyDescription*) description
{
	if(description && self.count)
	{
		NSArray* arrayTypes = description.arrayTypes;
		
		if(arrayTypes.count == 1)
		{
			GtPropertyDescription* elementDesc = [arrayTypes lastObject];
			for(id obj in self)
			{
				[builder openElement:elementDesc.propertyName];
				[builder writeObjectToStream:obj propertyDescription:elementDesc];
				[builder closeElement];
			}
		}
		else
		{
			for(id obj in self)
			{
				// need to decide for each item.
				
				for(GtPropertyDescription* elementDesc in arrayTypes)
				{
					if([obj isKindOfClass:elementDesc.propertyClass])
					{
						[builder openElement:elementDesc.propertyName];
						[builder writeObjectToStream:obj propertyDescription:elementDesc];
						[builder closeElement];
						break;
					}
				}
			}		
		}



//		// the first item type is of the array itself, e.g. Object, the second one is the
//		// first type for the array.
//		GtDataTypeStruct* arrayItemType = dataType->next;
//		GtAssert(arrayItemType != nil, @"arrayItemType is invalid");
//		if(arrayItemType)
//		{
//			// special case the case of a simple list (which is usual type)
//			if(arrayItemType->next == nil)
//			{
//				for(id obj in self)
//				{
//					[stream beginStreamingObjectForType:arrayItemType];
//					[stream writeObjectToStream:obj forType:arrayItemType];
//					[stream endStreamingObjectForType:arrayItemType];
//				}
//			}
//			else
//			{
//				for(id obj in self)
//				{
//					// need to decide for each item.
//					GtDataTypeStruct* itemType = GtGetTypeForClass(arrayItemType, obj);
//					GtAssertNotNil(itemType);
//					if(itemType)
//					{
//						[stream beginStreamingObjectForType:itemType];
//						[stream writeObjectToStream:obj forType:itemType];
//						[stream endStreamingObjectForType:itemType];
//					}
//				}
//			}
//		}
	}
#if DEBUG
	else if(!description)
	{
		GtLog(@"Warning not streaming object of type: %@", NSStringFromClass([self class]));
	}
#endif	
}
@end

@implementation NSMutableArray (XML)


- (void) finishParsingFrom:(GtXmlParser*) parser state:(GtObjectInflatorState*) state;
{
	if(!state.dataIsAttribute)
	{
		[self addObject:state.data];
	}
}

- (BOOL) beginParsingFrom:(GtXmlParser*) parser state:(GtObjectInflatorState*) state;
{
#if NEW_PARSER

	if(!state.dataIsAttribute)
	{
//		GtAssertNotNil(state.type);
		
		GtObjectDescriber* objectDescriber = state.prev.objectDescriber;
		GtPropertyDescription* parentDesc = [objectDescriber propertyDescriberForPropertyName:state.prev.key];
		NSArray* arrayTypes = parentDesc.arrayTypes;
		
		for(GtPropertyDescription* desc in arrayTypes)
		{
			if(GtStringsAreEqual(desc.propertyName, state.key))
			{
				state.parsedDataType = desc.propertyType;

				if(desc.propertyType == GtDataTypeObject)
				{
					GtAssertNotNil(desc.propertyClass);
				
					id obj = [[desc.propertyClass alloc] init];
					GtAssertNotNil(obj);
					[self addObject:obj];
					state.object = obj;
					GtRelease(obj);
				}
					
				//state.objectDescriber = prop;
			
				return YES;
			}
		}
		
		
		
//		GtDataTypeStruct* type = state.type; // already set to type of parent
//		while(type != nil)
//		{
//			if([type->key isEqualToString:state.key])
//			{
//				state.type = type;
//				
//				if(state.type->typeID == GtDataTypeObject)
//				{
//					GtAssertNotNil(state.type->objectClass);
//
//					id obj = [[state.type->objectClass alloc] init];
//					GtAssert(obj != nil, @"Unable to created object of type: %@", NSStringFromClass(state.type->objectClass));
//
//					GtAssertNotNil(obj);
//					[self addObject:obj];
//					GtRelease(obj);
//					
//					state.object = obj;
//				}
//
//				return YES;
//			}
//		
//			type = type->next;
//		}
//		
//		state.type = nil;
	}
#endif	
	return NO;
}

@end


@implementation GtXmlBuilder (NSObject)

- (void) addObjectAsXML:(id) object
{
	[object streamSelfToXmlBuilder:self propertyDescription:nil];
}

//- (void) beginStreamingObjectForType:(GtDataTypeStruct*) type
//{
//	[self openElement:type->key];
//}

- (void) writeObjectToStream:(id) object propertyDescription:(GtPropertyDescription*) description
{
	if(description.propertyType == GtDataTypeObject)
	{
		[object streamSelfToXmlBuilder:self propertyDescription:description];
	}
	else
	{
		[self addElementValueWithObject:object propertyDescription:description];
	}
}

//- (void) endStreamingObjectForType:(GtDataTypeStruct*) type
//{
//	[self closeElement];
//}


- (void) addElementValueWithObject:(id) object	propertyDescription:(GtPropertyDescription*) description
{
	if(object)
	{
		NSString* string = nil;
		[self.dataEncoder encodeDataToString:object forType:description.propertyType outEncodedString:&string];
		@try
		{
			[self addElementValueWithString:string];
		}
		@finally
		{
			GtRelease(string);
		}
	}
}

- (void) pushAttributeObject:(id) object attributeName:(NSString*)name propertyDescription:(GtPropertyDescription*) description
{
	if(object)
	{
		NSString* string = nil;
		[self.dataEncoder encodeDataToString:object forType:description.propertyType outEncodedString:&string];
		@try
		{
			[self pushAttributeString:string attributeName:name];
		}
		@finally
		{
			GtRelease(string);
		}
	}
}

- (void) addElementWithObjectValue:(id) object elementName:(NSString*) elementName propertyDescription:(GtPropertyDescription*) description
{
	if(object)
	{
		NSString* string = nil;
		[self.dataEncoder encodeDataToString:object forType:description.propertyType outEncodedString:&string];
		@try
		{
			[self addElementWithStringValue:string elementName:elementName];
		}
		@finally
		{
			GtRelease(string);
		}
	}
}

@end
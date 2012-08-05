//
//  NSObject+XML.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/30/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "NSObject+XML.h"
#import "FLObjectInflator.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflatorState.h"
#import "FLXmlParser.h"

@implementation NSObject (XML)

- (void) streamSelfToXmlBuilder:(FLXmlBuilder*) builder 
            propertyDescription:(FLPropertyDescription*) description
{
	FLObjectDescriber* objectDescriber = [[self class] sharedObjectDescriber];
	
	for(NSString* key in objectDescriber.propertyDescribers) {
		id object = [self valueForKey:key];
		if(object) {
			FLPropertyDescription* desc = [objectDescriber propertyDescriberForPropertyName:key];
		
			[builder openElement:key];

			if(desc.propertyType == FLDataTypeObject) {
				[object streamSelfToXmlBuilder:builder propertyDescription:desc];
			}
			else {
				[builder appendElementValueWithObject:object propertyDescription:desc];
			}
			
			[builder closeElement];
		}
	}
}

- (void) finishParsingFrom:(FLXmlParser*) parser 
                     state:(FLObjectInflatorState*) state;
{
	@try {
		[self setValue:state.data forKey:state.key];
	}
	@catch(NSException* ex) {
		FLDebugLog(@"unable to set value for %@: %@: %@", state.key, state.data, [ex description]);
	}
}

- (BOOL) beginParsingFrom:(FLXmlParser*) parser 
                    state:(FLObjectInflatorState*) state {
                    
	FLPropertyDescription* prop = [state.objectDescriber propertyDescriberForPropertyName:state.key];
	if(prop) {
		state.parsedDataType = prop.propertyType;
	
		if(prop.propertyType == FLDataTypeObject) {

            // this actually might return self or an inflator.
            // it relies on key value coding for setting the properties
            // <Foundation/NSKeyValueCoding.h>
			id inflator = [self objectInflator];
			
			id object = FLReturnRetained([inflator valueForKey:state.key forObject:self]);
			if(!object) {
				FLAssertIsNotNil(prop.propertyClass);

				object = [[prop.propertyClass alloc] init];
				[inflator setValue:object forKey:state.key forObject:self];
			}
		
            // i guess progate this?
            if(state.parseInfo) {
                [object setParseInfo:state.parseInfo];
            }
        
			FLAssertIsNotNil(object);
		
			state.object = object;
            
			FLRelease(object);
		}
		
		return YES;
	}
	
	return NO;
}

+ (id) objectWithContentsOfFile:(NSString*) path {
    NSError* error = nil;
    NSData* data = [NSData dataWithContentsOfFile:path options:NSDataReadingUncached error:&error];
    if(error) {
        FLThrowError(FLReturnAutoreleased(error));
    }

    FLXmlParser* parser = [FLXmlParser xmlParser:data];
    parser.fileName = path;
    parser.saveParsePositions = YES;
    
    id obj = FLReturnAutoreleased([[[self class] alloc] init]);
    [parser buildObjects:obj];
    return obj;
}

@end


@implementation NSArray (XML)

- (void) streamSelfToXmlBuilder:(FLXmlBuilder*) builder propertyDescription:(FLPropertyDescription*) description {
	if(description && self.count) {
		NSArray* arrayTypes = description.arrayTypes;
		
		if(arrayTypes.count == 1) {
			FLPropertyDescription* elementDesc = [arrayTypes lastObject];
			for(id obj in self){
				[builder openElement:elementDesc.propertyName];
				[builder writeObjectToStream:obj propertyDescription:elementDesc];
				[builder closeElement];
			}
		}
		else {
			for(id obj in self) {
				// hmm. expensive. need to decide for each item.
				
				for(FLPropertyDescription* elementDesc in arrayTypes) {
					if([obj isKindOfClass:elementDesc.propertyClass]) {
						[builder openElement:elementDesc.propertyName];
						[builder writeObjectToStream:obj propertyDescription:elementDesc];
						[builder closeElement];
						break;
					}
				}
			}		
		}
	}
#if DEBUG
	else if(!description) {
		FLDebugLog(@"Warning not streaming object of type: %@", NSStringFromClass([self class]));
	}
#endif	
}
@end

@implementation NSMutableArray (XML)


- (void) finishParsingFrom:(FLXmlParser*) parser state:(FLObjectInflatorState*) state {
	if(!state.dataIsAttribute) {
		[self addObject:state.data];
	}
}

- (BOOL) beginParsingFrom:(FLXmlParser*) parser state:(FLObjectInflatorState*) state {
	if(!state.dataIsAttribute) {
		
        FLObjectInflatorState* prev = state.previousObjectInLinkedList;
        
		FLObjectDescriber* objectDescriber = prev.objectDescriber;
		FLPropertyDescription* parentDesc = [objectDescriber propertyDescriberForPropertyName:prev.key];
		NSArray* arrayTypes = parentDesc.arrayTypes;
		
        FLParseInfo* parseInfo = state.parseInfo;
        
		for(FLPropertyDescription* desc in arrayTypes) {
			if(FLStringsAreEqual(desc.propertyName, state.key)) {
				state.parsedDataType = desc.propertyType;

				if(desc.propertyType == FLDataTypeObject) {
					FLAssertIsNotNil(desc.propertyClass);
				
					id obj = [[desc.propertyClass alloc] init];
					
                    if(parseInfo) {
                        [obj setParseInfo:parseInfo];
                    }   
                    
                    FLAssertIsNotNil(obj);
					[self addObject:obj];

// TODO: this seems wrong - always setting the state object to the most recent element
// in the list???	
// NOTE: removing it breaks the parsing, so whatever, but it still seems weird.
                    state.object = obj;

					FLRelease(obj);
				}
				return YES;
			}
		}
	}

	return NO;
}

@end


@implementation FLXmlBuilder (NSObject)

- (void) addObjectAsXML:(id) object {
	[object streamSelfToXmlBuilder:self propertyDescription:nil];
}

- (void) writeObjectToStream:(id) object propertyDescription:(FLPropertyDescription*) description {
	if(description.propertyType == FLDataTypeObject) {
		[object streamSelfToXmlBuilder:self propertyDescription:description];
	} 
    else {
		[self appendElementValueWithObject:object propertyDescription:description];
	}
}

- (void) appendElementValueWithObject:(id) object	propertyDescription:(FLPropertyDescription*) description {
	if(object) {
		NSString* string = nil;
		[self.dataEncoder encodeDataToString:object forType:description.propertyType outEncodedString:&string];
		@try{
			[self appendElementWithString:string];
		} 
        @finally {
			FLRelease(string);
		}
	}
}

- (void) pushAttribute:(NSString*) attributeName 
                object:(id) object 
   propertyDescription:(FLPropertyDescription*) description;
{
	if(object)
	{
		NSString* string = nil;
		[self.dataEncoder encodeDataToString:object forType:description.propertyType outEncodedString:&string];
		@try {
			[self pushAttribute:attributeName value:string];
		}
		@finally
		{
			FLRelease(string);
		}
	}
}

- (void) appendElement:(NSString*) elementName 
             object:(id) object 
propertyDescription:(FLPropertyDescription*) description
{
	if(object) {
		NSString* string = nil;
		[self.dataEncoder encodeDataToString:object forType:description.propertyType outEncodedString:&string];
		@try {
			[self appendElement:elementName value:string];
		}
		@finally {
			FLRelease(string);
		}
	}
}

@end
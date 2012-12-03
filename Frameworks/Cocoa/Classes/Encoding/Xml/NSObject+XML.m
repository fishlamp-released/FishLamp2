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

- (void) appendXmlToStringBuilder:(FLXmlStringBuilder*) stringBuilder
                  withDataEncoder:(id<FLDataEncoder>) dataEncoder
            propertyDescription:(FLPropertyDescription*) description
{
	FLObjectDescriber* objectDescriber = [[self class] sharedObjectDescriber];
	
	for(NSString* key in objectDescriber.propertyDescribers) {
		id object = [self valueForKey:key];
		if(object) {
            FLXmlElement* element = [FLXmlElement xmlElement:key];
            [stringBuilder addElement:element];
            FLPropertyDescription* desc = [objectDescriber propertyDescriberForPropertyName:key];
            if(desc.propertyType == FLDataTypeObject) {
                [object appendXmlToStringBuilder:element withDataEncoder:dataEncoder propertyDescription:desc];
            }
            else {
                [element appendElementValueWithObject:object withDataEncoder:dataEncoder propertyDescription:desc];
            }
        }
	}
}

- (void) finishParsingFrom:(FLXmlParser*) parser 
                     state:(FLObjectInflatorState*) state {
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
			
			id object = retain_([inflator valueForKey:state.key forObject:self]);
			if(!object) {
				FLAssertIsNotNil_(prop.propertyClass);

				object = [[prop.propertyClass alloc] init];
				[inflator setValue:object forKey:state.key forObject:self];
			}
		
            // i guess progate this?
            if(state.parseInfo) {
                [object setParseInfo:state.parseInfo];
            }
        
			FLAssertIsNotNil_(object);
		
			state.object = object;
            
			release_(object);
		}
		
		return YES;
	}
	
	return NO;
}

+ (id) objectWithContentsOfFile:(NSString*) path {
    NSError* error = nil;
    NSData* data = [NSData dataWithContentsOfFile:path options:NSDataReadingUncached error:&error];
    if(error) {
        FLThrowError_(autorelease_(error));
    }

    FLXmlParser* parser = [FLXmlParser xmlParser:data];
    parser.fileName = path;
    parser.saveParsePositions = YES;
    
    id obj = autorelease_([[[self class] alloc] init]);
    [parser buildObjects:obj];
    return obj;
}

@end


@implementation NSArray (XML)

- (void) streamSelfToXmlBuilder:(FLXmlStringBuilder*) stringBuilder
withDataEncoder:(id<FLDataEncoder>) dataEncoder
            propertyDescription:(FLPropertyDescription*) description {
    
	if(description && self.count) {
		NSArray* arrayTypes = description.arrayTypes;
		      
		if(arrayTypes.count == 1) {
			FLPropertyDescription* elementDesc = [arrayTypes lastObject];
			for(id obj in self){
                FLXmlElement* element = [FLXmlElement xmlElement:elementDesc.propertyName];
                [element addObjectAsXML:obj withDataEncoder:dataEncoder propertyDescription:elementDesc];
                [stringBuilder addElement:element];
			}
		}
		else {
			for(id obj in self) {
				// hmm. expensive. need to decide for each item.
				
				for(FLPropertyDescription* elementDesc in arrayTypes) {
					if([obj isKindOfClass:elementDesc.propertyClass]) {

                        FLXmlElement* element = [FLXmlElement xmlElement:elementDesc.propertyName];
                        [element addObjectAsXML:obj withDataEncoder:dataEncoder propertyDescription:elementDesc];
                        [stringBuilder addElement:element];
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
					FLAssertIsNotNil_(desc.propertyClass);
				
					id obj = [[desc.propertyClass alloc] init];
					
                    if(parseInfo) {
                        [obj setParseInfo:parseInfo];
                    }   
                    
                    FLAssertIsNotNil_(obj);
					[self addObject:obj];

// TODO: this seems wrong - always setting the state object to the most recent element
// in the list???	
// NOTE: removing it breaks the parsing, so whatever, but it still seems weird.
                    state.object = obj;

					release_(obj);
				}
				return YES;
			}
		}
	}

	return NO;
}

@end


@implementation FLXmlStringBuilder (NSObjectXML)

- (void) addObjectAsXML:(id) object 
        withDataEncoder:(id<FLDataEncoder>) dataEncoder {
	[object appendXmlToStringBuilder:self withDataEncoder:dataEncoder propertyDescription:nil];
}

- (void) addObjectAsXML:(id) object
        withDataEncoder:(id<FLDataEncoder>) dataEncoder
    propertyDescription:(FLPropertyDescription*) description {
	
    if(description.propertyType == FLDataTypeObject) {
		[object appendXmlToStringBuilder:self withDataEncoder:dataEncoder propertyDescription:description];
	} 
    else {
		[self appendElementValueWithObject:object withDataEncoder:dataEncoder propertyDescription:description];
	}
}

- (void) appendElementValueWithObject:(id) object
                      withDataEncoder:(id<FLDataEncoder>) dataEncoder
                  propertyDescription:(FLPropertyDescription*) description {

    if(object) {
        FLConfirmNotNil_v(dataEncoder, @"Xml String builder requires a data encoder");
    
		NSString* string = nil;
        [dataEncoder encodeDataToString:object forType:description.propertyType outEncodedString:&string];
        FLAssertNotNil_(string);
        FLConfirm_([string isKindOfClass:[NSString class]]);
        [self appendIndentedBlock:^{
            [self appendLine:string];
        }];
	}
}

- (void) addObjectAsXML:(id) object
        withDataEncoder:(id<FLDataEncoder>) dataEncoder
    propertyDescription:(FLPropertyDescription*) description
            elementName:(NSString*) elementName
{
	if(object) {
        FLConfirmNotNil_v(dataEncoder, @"Xml String builder requires a data encoder");
    
		NSString* string = nil;
		[dataEncoder encodeDataToString:object forType:description.propertyType outEncodedString:&string];
		@try {
            FLXmlElement* element = [FLXmlElement xmlElement:elementName];
            [element appendString:string];
            [self addElement:element];
		}
		@finally {
			release_(string);
		}
	}
}

@end
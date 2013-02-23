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
#import "NSObject+FLObjectBuilder.h"

@interface FLObjectBuilder ()
- (void) buildObject:(id) object 
      fromDictionary:(NSDictionary*) dictionary 
 withObjectDescriber:(FLObjectDescriber*) describer
         withDecoder:(id<FLDataDecoding>) decoder;

- (NSMutableArray*) addObjectsToArray:(NSMutableArray*) fromArray 
                          forProperty:(FLPropertyDescription*) propertyDescription
                          withDecoder:(id<FLDataDecoding>) decoder;

@property (readwrite, retain, nonatomic) id<FLDataDecoding> dataDecoder;
;

@property (readwrite, strong, nonatomic) id rootObject;

@end

@implementation FLObjectBuilder

@synthesize error = _error;
@synthesize dataDecoder = _dataDecoder;
@synthesize delegate = _delegate;
@synthesize rootObject = _rootObject;

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
                [newArray addObject:[arrayItemDesc.propertyType decodeStringToObject:arrayItem withDecoder:decoder]];
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
                        value = [property.propertyType decodeStringToObject:value withDecoder:decoder];
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
	
- (void) openWithRootObjectClass:(Class) theClass withDataDecoder:(id<FLDataDecoding>) decoder {

    self.rootObject = FLAutorelease([[theClass alloc] init]);    
        


}

- (id) finishBuilding {

    return self.rootObject;
}
    
- (NSString*) stateString {
    NSMutableString* string = [NSMutableString string];
    
    for(FLObjectInflatorState* state in _stack) {
        
        NSString* key = state.key;
        if(!key) {
            key = NSStringFromClass([state.object class]);
        }
        
        if(string.length > 0) {
            [string appendFormat:@".%@", key];
        } else {
            [string appendString:key];
        }
    }
    
    return string;
}

- (void) setError:(NSError*) error errorHint:(int) errorHint {
//    [super setError:error errorHint:errorHint != nil ? errorHint : [self stateString]];
}

- (FLObjectInflatorState*) firstObject {
    return [_stack firstObject];
}

- (FLObjectInflatorState*) lastObject {
    return [_stack lastObject];
}

- (void) appendString:(NSString*) string {
    
    if(FLStringIsNotEmpty(string)) {
        FLObjectInflatorState* lastState = self.lastObject;
        if(!lastState.data) {
            lastState.data = [NSMutableString stringWithString:string];
        }
        else {
            [lastState.data appendString:string];
        }
    }
}

- (FLObjectInflatorState*) openObject:(NSString*) objectName isAttribute:(BOOL) isAttribute {
    
   	@try {
        id targetObject = [self.lastObject object];
        
        FLObjectInflatorState* newState = [FLObjectInflatorState objectInflatorState:targetObject key:objectName];
        newState.objectDescriber = [targetObject objectDescriber];
        newState.dataIsAttribute = isAttribute;
        [_stack addObject:newState];
        
        [self.delegate objectBuilder:self willOpenObject:newState];

        if(![newState.object objectBuilder:self beginBuilding:newState]) {
    //        [self setError:[NSError errorWithDomain:FLXmlParserDomain 
    //                                           code:FLXmlParserErrorCodeUnknownElement 
    //                           localizedDescription:[NSString stringWithFormat:@"Unknown XML %@: %@", isAttribute ? @"attribute" : @"element", elementName]]
    //                                    errorHint:[self  stateString]];
        }
        
        FLAssertIsNotNil_(newState.object);
    }
    @catch(NSException* ex) {
//        [self setError:ex.error errorHint:[self stateString]];
	}
}

- (FLObjectInflatorState*) openObject:(NSString*) objectKey {
    return [self openObject:objectKey isAttribute:NO];
}

- (void) closeObject:(FLObjectInflatorState*) object {
    
@try {
	    
    FLAssertIsNotNil_(object.object);
	
    NSString* unparsedData = object.data; 
	
    if(unparsedData	 && unparsedData.length > 0) {
		unparsedData = [unparsedData stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
		if(unparsedData.length > 0) {
			if(object.parsedDataType) {

                FLAssertIsNotNil_(self.dataDecoder);
                
				id inflatedObject = [self.dataDecoder decodeDataFromString:unparsedData forType:object.parsedDataType]; 

				if(inflatedObject) {
					object.data = inflatedObject;
				}
				else {
					object.data = unparsedData; // trimmed.
				}
				
				[object.object objectBuilder:self finishBuilding:object];
			}
#if DEBUG	 
			else
			{
				FLDebugLog(@"Warning: %@ doesn't know about %@: %@: data: %@", NSStringFromClass([object.object class]), object.dataIsAttribute ? @"attribute" : @"element", object.key, unparsedData); 
			
			}
#endif				  
		}
	}
	
    [_stack removeLastObject];
    
    	}
	@catch(NSException* ex) {
	    [self setError:ex.error errorHint:[self stateString]];
	}

}
    
- (void) addObject:(NSString*) name data:(NSString*) data {
    FLObjectInflatorState* element = [self openObject:name];
    [self appendString:data];
    [self closeObject:element];
}    

- (void) addAttribute:(NSString*) name data:(NSString*) data {
    FLObjectInflatorState* element = [self openObject:name isAttribute:YES];
    [self appendString:data];
    [self closeObject:element];
}

    
@end

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
#import "FLPropertyDescription.h"

@implementation NSObject (XML)

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
			
			id object = FLRetain([inflator valueForKey:state.key forObject:self]);
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
            
			FLRelease(object);
		}
		
		return YES;
	}
	
	return NO;
}

+ (id) objectWithContentsOfXMLFile:(NSString*) path {
    NSError* error = nil;
    NSData* data = [NSData dataWithContentsOfFile:path options:NSDataReadingUncached error:&error];
    if(error) {
        FLThrowError(FLAutorelease(error));
    }

    FLXmlParser* parser = [FLXmlParser xmlParser:data];
    parser.fileName = path;
    parser.saveParsePositions = YES;
    
    id obj = FLAutorelease([[[self class] alloc] init]);
    [parser buildObjects:obj];
    return obj;
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

					FLRelease(obj);
				}
				return YES;
			}
		}
	}

	return NO;
}

@end

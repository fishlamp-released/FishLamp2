//
//  NSObject+FLObjectBuilder.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/23/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "NSObject+FLObjectBuilder.h"
#import "FLObjectInflator.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflatorState.h"
#import "FLPropertyDescription.h"

@implementation NSObject (FLObjectBuilder)

- (void) objectBuilder:(FLObjectBuilder*) builder 
        finishBuilding:(FLObjectInflatorState*) state {
        
	@try {
		[self setValue:state.data forKey:state.key];
	}
	@catch(NSException* ex) {
		FLDebugLog(@"unable to set value for %@: %@: %@", state.key, state.data, [ex description]);
	}
}

- (BOOL) objectBuilder:(FLObjectBuilder*) builder 
         beginBuilding:(FLObjectInflatorState*) state {
                    
	FLPropertyDescription* prop = [state.objectDescriber propertyDescriberForPropertyName:state.key];
	if(prop) {
		state.parsedDataType = prop.propertyType;
	
		if(prop.propertyType.isObject) {

            // this actually might return self or an inflator.
            // it relies on key value coding for setting the properties
            // <Foundation/NSKeyValueCoding.h>
			id inflator = [self objectInflator];
			
			id object = FLRetainWithAutorelease([inflator valueForKey:state.key forObject:self]);
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
         }
		
		return YES;
	}
	
	return NO;
}

@end

@implementation NSMutableArray (FLObjectBuilder)

- (void) objectBuilder:(FLObjectBuilder*) builder 
        finishBuilding:(FLObjectInflatorState*) state {
        
	if(!state.dataIsAttribute) {
		[self addObject:state.data];
	}
}

- (BOOL) objectBuilder:(FLObjectBuilder*) builder 
         beginBuilding:(FLObjectInflatorState*) state {
         
	if(!state.dataIsAttribute) {
		
        FLObjectInflatorState* prev = state.previousObjectInLinkedList;
        
		FLObjectDescriber* objectDescriber = prev.objectDescriber;
		FLPropertyDescription* parentDesc = [objectDescriber propertyDescriberForPropertyName:prev.key];
		NSArray* arrayTypes = parentDesc.arrayTypes;
		
        FLParseInfo* parseInfo = state.parseInfo;
        
		for(FLPropertyDescription* desc in arrayTypes) {
			if(FLStringsAreEqual(desc.propertyName, state.key)) {
				state.parsedDataType = desc.propertyType;

                if(desc.propertyType.isObject) {
					FLAssertIsNotNil_(desc.propertyClass);
				
					id obj = FLAutorelease([[desc.propertyClass alloc] init]);
					
                    if(parseInfo) {
                        [obj setParseInfo:parseInfo];
                    }   
                    
                    FLAssertIsNotNil_(obj);
					[self addObject:obj];

// TODO: this seems wrong - always setting the state object to the most recent element
// in the list???	
// NOTE: removing it breaks the parsing, so whatever, but it still seems weird.
                    state.object = obj;
                }
				return YES;
			}
		}
	}

	return NO;
}

@end

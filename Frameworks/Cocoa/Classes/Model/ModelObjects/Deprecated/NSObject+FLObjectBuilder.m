//
//  NSObject+FLObjectBuilder.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/23/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#if REFACTOR

#import "NSObject+FLObjectBuilder.h"
#import "FLObjectInflator.h"
#import "FLObjectDescriber.h"
#import "FLPropertyInflator.h"
#import "FLPropertyType.h"

#import "FLXmlObjectBuilder.h"

@implementation NSObject (FLObjectBuilder)

- (void) objectBuilder:(FLObjectBuilder*) builder 
        finishBuilding:(FLPropertyInflator*) propertyInflator {
        
	@try {
		[self setValue:propertyInflator.inflatedPropertyObject forKey:propertyInflator.propertyName];
	}
	@catch(NSException* ex) {
		FLDebugLog(@"unable to set value for %@: %@: %@", propertyInflator.propertyName, propertyInflator.encodedString, [ex description]);
	}
}

- (BOOL) objectBuilder:(FLObjectBuilder*) builder 
         beginBuilding:(FLPropertyInflator*) propertyInflator {
                    
    if(![self isModelObject]) {
        return NO;
    }

    FLObjectDescriber* describer = [self objectDescriber];
                    
	FLPropertyType* prop = [describer propertyDescriberForPropertyName:propertyInflator.propertyName];
    
	if(prop && [prop.classForType sharedObjectDescriber]) {
		    // this actually might return self or an inflator.
            // it relies on propertyName value coding for setting the properties
            // <Foundation/NSKeyValueCoding.h>
			id inflator = [self objectInflator];
			
			id object = FLRetainWithAutorelease([inflator valueForKey:propertyInflator.propertyName forObject:self]);
			if(!object) {
				FLAssertIsNotNil_(prop.classForType);

				object = FLAutorelease([[prop.classForType alloc] init]);
                FLAssertNotNil(object);
                
				[inflator setValue:object forKey:propertyInflator.propertyName forObject:self];
			}
		        
			FLAssertIsNotNil_(object);
// setting this here, so next messages go to new object.            
			propertyInflator.containingObject = object;
         
		
		return YES;
	}
	
	return NO;
}

@end

@implementation NSMutableArray (FLObjectBuilder)

- (void) objectBuilder:(FLObjectBuilder*) builder 
        finishBuilding:(FLPropertyInflator*) propertyInflator {
        
	if(propertyInflator.state != FLXmlPropertyInflationIsAttribute) {
		[self addObject:propertyInflator.inflatedPropertyObject];
	}
}

- (BOOL) objectBuilder:(FLObjectBuilder*) builder 
         beginBuilding:(FLPropertyInflator*) propertyInflator {
         
	if(propertyInflator.state != FLXmlPropertyInflationIsAttribute) {
		
        FLPropertyInflator* prev = [builder previousStateForState:propertyInflator];
        
		FLObjectDescriber* objectDescriber = [prev.containingObject objectDescriber];
		
        FLPropertyType* parentDesc = [objectDescriber propertyDescriberForPropertyName:prev.propertyName];
		NSArray* arrayTypes = parentDesc.arrayTypes;
		        
		for(FLPropertyType* propertyType in arrayTypes) {
			
            if(FLStringsAreEqual(propertyType.propertyName, propertyInflator.propertyName)) {
				
				propertyInflator = propertyType;

                FLAssertIsNotNil_(propertyType.classForType);

                FLObjectDescriber* arrayItemDescriber = [propertyType.classForType sharedObjectDescriber]; 
                if(arrayItemDescriber) {
                    id obj = FLAutorelease([[propertyType.classForType alloc] init]);
                    FLAssertIsNotNil_(obj);
					[self addObject:obj];

//                    self = obj;
                }
				return YES;
			}
		}
	}

	return NO;
}

@end





#endif
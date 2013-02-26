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
#import "FLPropertyInflator.h"
#import "FLPropertyDescription.h"

#import "FLXmlObjectBuilder.h"
#import "FLCoreTypes.h"

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
                    
    FLObjectDescriber* describer = [self objectDescriber];
    if(!describer) {
        return NO;
    }
                    
	FLPropertyDescription* prop = [describer propertyDescriberForPropertyName:propertyInflator.propertyName];
    
	if(prop && [prop.propertyType.typeClass sharedObjectDescriber]) {
		    // this actually might return self or an inflator.
            // it relies on propertyName value coding for setting the properties
            // <Foundation/NSKeyValueCoding.h>
			id inflator = [self objectInflator];
			
			id object = FLRetainWithAutorelease([inflator valueForKey:propertyInflator.propertyName forObject:self]);
			if(!object) {
				FLAssertIsNotNil_(prop.propertyType.typeClass);

				object = FLAutorelease([[prop.propertyType.typeClass alloc] init]);
                FLAssertNotNil_(object);
                
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
		
        FLPropertyDescription* parentDesc = [objectDescriber propertyDescriberForPropertyName:prev.propertyName];
		NSArray* arrayTypes = parentDesc.arrayTypes;
		        
		for(FLPropertyDescription* propertyDescription in arrayTypes) {
			
            if(FLStringsAreEqual(propertyDescription.propertyName, propertyInflator.propertyName)) {
				
				propertyInflator.propertyType = propertyDescription.propertyType;

                FLAssertIsNotNil_(propertyDescription.propertyType.typeClass);

                FLObjectDescriber* arrayItemDescriber = [propertyDescription.propertyType.typeClass sharedObjectDescriber]; 
                if(arrayItemDescriber) {
                    id obj = FLAutorelease([[propertyDescription.propertyType.typeClass alloc] init]);
                    FLAssertIsNotNil_(obj);
					[self addObject:obj];

                    self = obj;
                }
				return YES;
			}
		}
	}

	return NO;
}

@end






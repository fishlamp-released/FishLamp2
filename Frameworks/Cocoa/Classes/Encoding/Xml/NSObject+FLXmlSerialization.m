//
//  NSObject+FLXmlSerialization.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "NSObject+FLXmlSerialization.h"
#import "FLObjectXmlElement.h"

@implementation NSObject (FLXmlSerialization)

- (void) addToXmlElement:(FLXmlElement*) xmlElement
       propertyDescriber:(FLPropertyDescriber*) propertyDescriber {
      
	if([[self class] isModelObject]) {
    
      	FLObjectDescriber* typeDesc = [[self class] objectDescriber];
        for(FLPropertyDescriber* property in [typeDesc.properties objectEnumerator]) {

            id object = [self valueForKey:property.propertyName];
            if(object) {
                [xmlElement addElement:[FLObjectXmlElement objectXmlElement:object 
                                                              xmlElementTag:property.propertyName 
                                                          propertyDescriber:property]];
            }
        }
    }
    else {
        FLObjectEncoder* objectEncoder = [self.class objectEncoder];
        if(objectEncoder) {
            NSString* line = [objectEncoder encodeObjectToString:self withEncoder:xmlElement.dataEncoder];
            [xmlElement appendLine:line];
        }
        else {
            FLLog(@"No encoder for %@ found", NSStringFromClass([self class]));
        }
    }
}

@end


@implementation NSArray (FLXmlSerialization)

- (void) addToXmlElement:(FLXmlElement*) xmlElement
       propertyDescriber:(FLPropertyDescriber*) propertyDescriber {
    
	if(propertyDescriber && self.count) {

		if(propertyDescriber.containedTypes.count == 1) {
			FLPropertyDescriber* elementDesc = [propertyDescriber.containedTypes objectAtIndex:0];

			for(id obj in self){
                [xmlElement addElement:[FLObjectXmlElement objectXmlElement:obj xmlElementTag:elementDesc.propertyName propertyDescriber:elementDesc]];
			}
		}
		else {
        
            for(id obj in self) {
				// hmm. expensive. need to decide for each item.
                
                BOOL found = NO;
                for(FLPropertyDescriber* subType in propertyDescriber.containedTypes) {
					if([obj isKindOfClass:[subType propertyClass]]) {
                        [xmlElement addElement:[FLObjectXmlElement objectXmlElement:obj xmlElementTag:subType.propertyName propertyDescriber:subType]];
                        found = YES;
						break;
					}
				}
                if(!found) {
                    FLLog(@"array property describer for %@ not found", NSStringFromClass([obj class]));
                
                }
			}		
		}
	}
#if DEBUG
	else if(!propertyDescriber) {
		FLDebugLog(@"Warning not streaming object of type: %@", NSStringFromClass([self class]));
	}
#endif	
}
@end


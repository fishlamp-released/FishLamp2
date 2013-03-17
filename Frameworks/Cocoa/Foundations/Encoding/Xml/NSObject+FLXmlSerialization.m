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
            propertyType:(FLPropertyType*) propertyType {
      
	FLObjectDescriber* objectDescriber = [[self class] sharedObjectDescriber];
	if(objectDescriber) {
        for(FLPropertyType* property in [objectDescriber.properties objectEnumerator]) {
            
            id object = [self valueForKey:property.propertyName];
            if(object) {
                [xmlElement addElement:[FLObjectXmlElement objectXmlElement:object xmlElementTag:property.propertyName propertyType:property]];
            }
        }
    }
    else {
        id<FLDataEncoding> encoder = xmlElement.dataEncoder;
        FLAssertNotNil_(encoder);
        
        NSString* line = [propertyType.propertyType encodeObjectToString:self withEncoder:encoder];

        [xmlElement appendLine:line];
    }
}

@end


@implementation NSArray (FLXmlSerialization)

- (void) addToXmlElement:(FLXmlElement*) xmlElement
     propertyType:(FLPropertyType*) description {
    
	if(description && self.count) {
		NSArray* arrayTypes = description.arrayTypes;
		      
		if(arrayTypes.count == 1) {
			FLPropertyType* elementDesc = [arrayTypes lastObject];

			for(id obj in self){
                [xmlElement addElement:[FLObjectXmlElement objectXmlElement:obj xmlElementTag:elementDesc.propertyName propertyType:elementDesc]];
			}
		}
		else {
			for(id obj in self) {
				// hmm. expensive. need to decide for each item.
				
				for(FLPropertyType* subType in arrayTypes) {
					if([obj isKindOfClass:subType.propertyClass]) {
                        [xmlElement addElement:[FLObjectXmlElement objectXmlElement:obj xmlElementTag:subType.propertyName propertyType:subType]];
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


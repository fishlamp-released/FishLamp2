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
     propertyType:(FLPropertyType*) description {
      
	FLObjectDescriber* objectDescriber = [[self class] sharedObjectDescriber];
	if(objectDescriber) {
        for(FLPropertyType* property in [objectDescriber.propertyDescribers objectEnumerator]) {
            
            id object = [self valueForKey:property.propertyName];
            if(object) {
                [xmlElement addElement:[FLObjectXmlElement objectXmlElement:object xmlElementTag:property.propertyName propertyType:property]];
            }
        }
    }
    else {
        FLAssertNotNil_(description);
        
        FLType* type = description.propertyType;
        FLAssertNotNil_(type);
        
        id<FLDataEncoding> encoder = xmlElement.dataEncoder;
        FLAssertNotNil_(encoder);
        
        NSString* line = [type encodeObjectToString:self withEncoder:encoder];

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
				
				for(FLPropertyType* elementDesc in arrayTypes) {
					if([obj isKindOfClass:elementDesc.propertyType.classForType]) {
                        [xmlElement addElement:[FLObjectXmlElement objectXmlElement:obj xmlElementTag:elementDesc.propertyName propertyType:elementDesc]];
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


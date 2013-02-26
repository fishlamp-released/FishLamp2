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
     propertyDescription:(FLPropertyDescription*) description {
      
	FLObjectDescriber* objectDescriber = [[self class] sharedObjectDescriber];
	if(objectDescriber) {
        for(FLPropertyDescription* property in [objectDescriber.propertyDescribers objectEnumerator]) {
            
            id object = [self valueForKey:property.propertyName];
            if(object) {
                [xmlElement addElement:[FLObjectXmlElement objectXmlElement:object xmlElementTag:property.propertyName propertyDescription:property]];
            }
        }
    }
    else {
        FLAssertNotNil_(description);
        
        FLTypeDesc* typeDesc = description.propertyType;
        FLAssertNotNil_(typeDesc);
        
        id<FLDataEncoding> encoder = xmlElement.dataEncoder;
        FLAssertNotNil_(encoder);
        
        NSString* line = [typeDesc encodeObjectToString:self withEncoder:encoder];

        [xmlElement appendLine:line];
    }
}

@end


@implementation NSArray (FLXmlSerialization)

- (void) addToXmlElement:(FLXmlElement*) xmlElement
     propertyDescription:(FLPropertyDescription*) description {
    
	if(description && self.count) {
		NSArray* arrayTypes = description.arrayTypes;
		      
		if(arrayTypes.count == 1) {
			FLPropertyDescription* elementDesc = [arrayTypes lastObject];

			for(id obj in self){
                [xmlElement addElement:[FLObjectXmlElement objectXmlElement:obj xmlElementTag:elementDesc.propertyName propertyDescription:elementDesc]];
			}
		}
		else {
			for(id obj in self) {
				// hmm. expensive. need to decide for each item.
				
				for(FLPropertyDescription* elementDesc in arrayTypes) {
					if([obj isKindOfClass:elementDesc.propertyType.typeClass]) {
                        [xmlElement addElement:[FLObjectXmlElement objectXmlElement:obj xmlElementTag:elementDesc.propertyName propertyDescription:elementDesc]];
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


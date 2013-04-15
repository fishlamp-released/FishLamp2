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
                typeDesc:(FLTypeDesc*) parentObject {
      
	FLTypeDesc* typeDesc = [[self class] objectDescriber];
	if(typeDesc) {
        for(FLTypeDesc* property in [typeDesc.subtypes objectEnumerator]) {
            if(property.objectEncoder) {
                id object = [self valueForKey:property.identifier];
                if(object) {
                    [xmlElement addElement:[FLObjectXmlElement objectXmlElement:object xmlElementTag:property.identifier typeDesc:property]];
                }
            }
        }
    }
    else {
        FLObjectEncoder* objectEncoder = [parentObject objectEncoder];
        if(objectEncoder) {
            NSString* line = [objectEncoder encodeObjectToString:self withEncoder:xmlElement.dataEncoder];
            [xmlElement appendLine:line];
        }
    }
}

@end


@implementation NSArray (FLXmlSerialization)

- (void) addToXmlElement:(FLXmlElement*) xmlElement
                typeDesc:(FLTypeDesc*) typeDesc {
    
	if(typeDesc && self.count) {
		NSDictionary* arrayTypes = typeDesc.subtypes;
		      
		if(arrayTypes.count == 1) {
			FLTypeDesc* elementDesc = [[arrayTypes allValues] lastObject];

			for(id obj in self){
                [xmlElement addElement:[FLObjectXmlElement objectXmlElement:obj xmlElementTag:elementDesc.identifier typeDesc:elementDesc]];
			}
		}
		else {
			for(id obj in self) {
				// hmm. expensive. need to decide for each item.
				
				for(FLTypeDesc* subType in [arrayTypes objectEnumerator]) {
					if([obj isKindOfClass:subType.objectClass]) {
                        [xmlElement addElement:[FLObjectXmlElement objectXmlElement:obj xmlElementTag:subType.identifier typeDesc:subType]];
						break;
					}
				}
			}		
		}
	}
#if DEBUG
	else if(!typeDesc) {
		FLDebugLog(@"Warning not streaming object of type: %@", NSStringFromClass([self class]));
	}
#endif	
}
@end


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
                typeDesc:(FLObjectDescriber*) parentObject {
      
	if([[self class] isModelObject]) {
      	FLObjectDescriber* typeDesc = [[self class] objectDescriber];
        for(NSUInteger i = 0; i < typeDesc.subTypeCount; i++) {
            FLObjectDescriber* property = [typeDesc subTypeForIndex:i];
    
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
                typeDesc:(FLObjectDescriber*) typeDesc {
    
	if(typeDesc && self.count) {
		if(typeDesc.subTypeCount == 1) {
			FLObjectDescriber* elementDesc = [typeDesc subTypeForIndex:0];

			for(id obj in self){
                [xmlElement addElement:[FLObjectXmlElement objectXmlElement:obj xmlElementTag:elementDesc.identifier typeDesc:elementDesc]];
			}
		}
		else {
            NSArray* subTypes = [typeDesc subTypesCopy];
        
			for(id obj in self) {
				// hmm. expensive. need to decide for each item.
				                
                for(FLObjectDescriber* subType in subTypes) {
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


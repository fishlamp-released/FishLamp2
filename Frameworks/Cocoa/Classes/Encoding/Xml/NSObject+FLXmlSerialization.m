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
            objectDescriber:(FLObjectDescriber*) parentObject {
      
	FLObjectDescriber* objectDescriber = [[self class] objectDescriber];
	if(objectDescriber) {
        for(FLObjectDescriber* property in [objectDescriber.childDescribers objectEnumerator]) {
            if(property.objectEncoder) {
                id object = [self valueForKey:property.objectName];
                if(object) {
                    [xmlElement addElement:[FLObjectXmlElement objectXmlElement:object xmlElementTag:property.objectName objectDescriber:property]];
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
     objectDescriber:(FLObjectDescriber*) description {
    
	if(description && self.count) {
		NSDictionary* arrayTypes = description.childDescribers;
		      
		if(arrayTypes.count == 1) {
			FLObjectDescriber* elementDesc = [[arrayTypes allValues] lastObject];

			for(id obj in self){
                [xmlElement addElement:[FLObjectXmlElement objectXmlElement:obj xmlElementTag:elementDesc.objectName objectDescriber:elementDesc]];
			}
		}
		else {
			for(id obj in self) {
				// hmm. expensive. need to decide for each item.
				
				for(FLObjectDescriber* subType in [arrayTypes objectEnumerator]) {
					if([obj isKindOfClass:subType.objectClass]) {
                        [xmlElement addElement:[FLObjectXmlElement objectXmlElement:obj xmlElementTag:subType.objectName objectDescriber:subType]];
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


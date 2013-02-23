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
	
	for(NSString* key in objectDescriber.propertyDescribers) {
		id object = [self valueForKey:key];
		if(object) {
            
            FLPropertyDescription* desc = [objectDescriber propertyDescriberForPropertyName:key];
           
            if(desc.propertyType.isObject) {
                [xmlElement addElement:
                    [FLObjectXmlElement objectXmlElement:object xmlElementTag:key propertyDescription:desc]];
            }
            else {
                [xmlElement appendLine:object];
//                addStringBuilderLine:
//                    [FLXmlElementStringBuilderLine xmlElementStringBuilderLine:object propertyDescription:desc]];
            }
        }
	}
}

@end
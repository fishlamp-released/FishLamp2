//
//  NSObject+FLXmlObjectBuilder.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 5/7/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLObjectDescriber+FLXmlObjectBuilder.h"
#import "FLXmlObjectBuilder.h"
#import "FLParsedXmlElement.h"
#import "FLModelObject.h"
#import "FLPropertyDescriber+XmlObjectBuilder.h"
#import "FLStringToObjectConversionManager.h"

@implementation FLObjectDescriber (FLXmlObjectBuilder)

- (id) buildObjectWithObjectBuilder:(FLXmlObjectBuilder*) builder
                            withXML:(FLParsedXmlElement*) element {

//    NSString* encodingKey = typeDesc.stringEncodingKeyForRepresentedData;
//    if(encodingKey) {
//        FLAssertNotNil(builder.decoder);
//        return [builder.decoder objectFromString:self forTypeName:forTypeName];

    NSString* forTypeName = [[self objectClass] typeNameForStringToObjectConverting];
  
    id object = [builder.decoder objectFromString:[element elementValue] forTypeName:forTypeName];
    FLAssertNotNil(object);

    return object;
}
     
@end

@implementation FLModelObjectDescriber (FLXmlObjectBuilder)

- (id) buildObjectWithObjectBuilder:(FLXmlObjectBuilder*) builder
                            withXML:(FLParsedXmlElement*) parentElement {

    FLAssert([self.objectClass isModelObject]);

//    FLConfirmIsNilWithComment(element.siblingElement, @"duplicate elements for property \"%@\"", element.elementName);   
    
    id outObject = FLAutorelease([[self.objectClass alloc] init]);
    
    for(FLParsedXmlElement* element in [parentElement.childElements objectEnumerator]) {
        
        if(FLStringsAreEqual(element.elementName, @"Id")) {
            FLLog(@"wtf");
        }   
        
        FLPropertyDescriber* propertyDescriber = [self propertyForName:element.elementName];

        NSString* propertyName = propertyDescriber.propertyName;


        if(propertyDescriber) {


            id object = [propertyDescriber xmlObjectBuilder:builder  
                                     inflateElementContents:element];

            if(object) {
                if([outObject valueForKey:propertyName]) {
                    FLTrace(@"replacing non-nil value for [%@ %@]", NSStringFromClass([object class]),  element.fullPath);
                } 
            
//                FLAssertNil([outObject valueForKey:element.elementName]);
            
                [outObject setValue:object forKey:propertyName];
            }
            else {

                if(FLStringIsNotEmpty(element.elementValue)) {

                    FLTrace(@"object not inflated for %@.%@", NSStringFromClass([outObject class]), element.fullPath);

                    if(builder.strict) {
                        FLConfirmationFailureWithComment(@"object not inflated for \"%@\" (%@)", element.fullPath, element.elementValue);
                    }
                }
            }
        }
        else {
            propertyDescriber = [self propertyForContainerTypeByName:element.elementName];
            if(propertyDescriber) {
            
                NSMutableArray* array = [outObject valueForKey:propertyDescriber.propertyName];
                if(!array) {
                    array = [NSMutableArray array];
                    [outObject setValue:array forKey:propertyDescriber.propertyName];
                }
                
                FLParsedXmlElement* walker = element;
                while(walker){ 
                    FLPropertyDescriber* containedType = [propertyDescriber containedTypeForName:walker.elementName];
                    id objectForArray = [containedType xmlObjectBuilder:builder inflateElementContents:walker];
                    
                    if(objectForArray) {
                        [array addObject:objectForArray];
                    }
                    else {
                        FLTrace(@"array object not inflated for %@.%@",
                            NSStringFromClass([outObject class]),
                            walker.fullPath);

                        if(builder.strict) {
                            FLConfirmationFailureWithComment(@"Array object not inflated: %@:%@", NSStringFromClass([outObject class]), walker.fullPath);
                        }

                    }
                    walker = walker.siblingElement;
                }
            }
            else {
                FLTrace(@"object builder skipped missing propertyDescriber named: %@:%@", NSStringFromClass(self.objectClass),element.fullPath);

                if(builder.strict) {
                    FLConfirmationFailureWithComment(@"Unknown property: %@", element.fullPath);
                }

            }
        }
        
    }
    
    return outObject;
}

@end



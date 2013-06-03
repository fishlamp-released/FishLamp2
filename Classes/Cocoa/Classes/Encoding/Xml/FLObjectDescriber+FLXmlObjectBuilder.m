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

@implementation FLObjectDescriber (FLXmlObjectBuilder)

- (id) xmlObjectBuilder:(FLXmlObjectBuilder*) builder 
   inflateRootObjectWithXML:(FLParsedXmlElement*) element {

//    NSString* encodingKey = typeDesc.stringEncodingKeyForRepresentedData;
//    if(encodingKey) {
//        FLAssertNotNil(builder.decoder);
//        return [builder.decoder objectFromString:self encodingKey:encodingKey];

    NSString* encodingKey = [[self objectClass] stringEncodingKey];
  
    id object = [builder.decoder objectFromString:[element elementValue] encodingKey:encodingKey];
    FLAssertNotNil(object);

    return object;
}
     
@end

@implementation FLModelObjectDescriber (FLXmlObjectBuilder)

- (id) xmlObjectBuilder:(FLXmlObjectBuilder*) builder 
   inflateRootObjectWithXML:(FLParsedXmlElement*) parentElement {

    FLAssert([self.objectClass isModelObject]);

//    FLConfirmIsNilWithComment(element.sibling, @"duplicate elements for property \"%@\"", element.elementName);   
    
    id outObject = FLAutorelease([[self.objectClass alloc] init]);
    
    for(FLParsedXmlElement* element in [parentElement.childElements objectEnumerator]) {
        
        FLPropertyDescriber* propertyDescriber = [self propertyForName:element.elementName];
        if(propertyDescriber) {
                
            id object = [propertyDescriber xmlObjectBuilder:builder  
                                     inflateElementContents:element];
            
            if(object) {
                if([outObject valueForKey:element.elementName]) {
                    FLTrace(@"replacing non-nil value for [%@ %@]", NSStringFromClass([object class]),  element.elementName);
                } 
            
//                FLAssertNil([outObject valueForKey:element.elementName]);
            
                [outObject setValue:object forKey:element.elementName];
            }
            else {
                FLTrace(@"object not inflated for %@.%@", NSStringFromClass([outObject class]), element.elementName);
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
                        FLLog(@"array object not inflated for %@.%@", NSStringFromClass([outObject class]), walker.elementName);
                    }
                    walker = walker.sibling;
                }
            }
            else {
                FLLog(@"object builder skipped missing propertyDescriber named: %@:%@", NSStringFromClass(self.objectClass),element.elementName);
            }
        }
        
    }
    
    return outObject;
}

@end



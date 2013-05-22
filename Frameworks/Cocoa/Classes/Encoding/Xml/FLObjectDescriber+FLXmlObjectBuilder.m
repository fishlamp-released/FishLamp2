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
   inflateRootObjectWithXML:(FLParsedXmlElement*) element {

    FLAssert([self.objectClass isModelObject]);
    
    id outObject = FLAutorelease([[self.objectClass alloc] init]);
    
    for(id elementName in element.childElements) {
        
        FLPropertyDescriber* propertyDescriber = [self propertyForName:elementName];
        if(!propertyDescriber) {
            FLLog(@"object builder skipped missing propertyDescriber named: %@:%@", NSStringFromClass(self.objectClass),elementName);
            continue;
        }
        
        FLParsedXmlElement* childElement = [element childElementForName:elementName];
            
        id object = [propertyDescriber xmlObjectBuilder:builder  
                                 inflateElementContents:childElement];
        
        if(object) {
            [outObject setValue:object forKey:elementName];
        }
        else {
            FLLog(@"object not inflated for %@.%@", NSStringFromClass([outObject class]), elementName);
        }
    }
    
    return outObject;
}

@end



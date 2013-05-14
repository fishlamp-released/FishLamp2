//
//  NSObject+FLXmlObjectBuilder.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 5/7/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjectDescriber+FLXmlObjectBuilder.h"
#import "FLXmlObjectBuilder.h"
#import "FLParsedItem.h"
#import "FLModelObject.h"
#import "FLPropertyDescriber+XmlObjectBuilder.h"

@implementation FLObjectDescriber (FLXmlObjectBuilder)

- (id) xmlObjectBuilder:(FLXmlObjectBuilder*) builder 
   inflateRootObjectWithXML:(FLParsedItem*) element {

//    NSString* encodingKey = typeDesc.stringEncodingKeyForRepresentedData;
//    if(encodingKey) {
//        FLAssertNotNil(builder.decoder);
//        return [builder.decoder objectFromString:self encodingKey:encodingKey];

    NSString* encodingKey = [[self objectClass] stringEncodingKey];
  
    id object = [builder.decoder objectFromString:[element value] encodingKey:encodingKey];
    FLAssertNotNil(object);

    return object;
}
     
@end

@implementation FLModelObjectDescriber (FLXmlObjectBuilder)

- (id) xmlObjectBuilder:(FLXmlObjectBuilder*) builder 
   inflateRootObjectWithXML:(FLParsedItem*) element {

    FLAssert([self.objectClass isModelObject]);
    
    id outObject = FLAutorelease([[self.objectClass alloc] init]);
    
    for(id elementName in element.elements) {
        
        FLPropertyDescriber* propertyDescriber = [self propertyForName:elementName];
        if(!propertyDescriber) {
            FLLog(@"object builder skipped missing propertyDescriber named: %@", elementName);
            continue;
        }
        
        // this can be either an array or another FLParsedItem
        id elementContents = [element.elements objectForKey:elementName];
            
        id object = [propertyDescriber xmlObjectBuilder:builder  
                                 inflateElementContents:elementContents];
        
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


//
//  NSObject+FLXmlObjectBuilder.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 5/7/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "NSObject+FLXmlObjectBuilder.h"
#import "FLParsedItem.h"
#import "FLXmlObjectBuilder.h"
#import "FLObjectDescriber+FLXmlObjectBuilder.h"

@implementation NSObject (FLXmlObjectBuilder)
+ (id) objectWithXmlElement:(FLParsedItem*) xmlElement 
          withObjectBuilder:(FLXmlObjectBuilder*) builder {
          
    FLAssertNotNil(builder);
    FLAssertNotNil(builder.decoder);
    FLAssertNotNil(xmlElement);

    FLObjectDescriber* objectDescriber = [self objectDescriber];
    return [objectDescriber xmlObjectBuilder:builder inflateObjectWithXml:xmlElement];
}


+ (id) objectWithXmlElement:(FLParsedItem*) xmlElement 
                elementName:(NSString*) elementName
          withObjectBuilder:(FLXmlObjectBuilder*) builder {

    FLAssertNotNil(builder);
    FLAssertNotNil(builder.decoder);
    FLAssertNotNil(xmlElement);
    
    FLParsedItem* buildElement = [builder findElementForBuilding:elementName inParentElement:xmlElement];
    
    return [self objectWithXmlElement:buildElement withObjectBuilder:builder];
                      
}          

@end

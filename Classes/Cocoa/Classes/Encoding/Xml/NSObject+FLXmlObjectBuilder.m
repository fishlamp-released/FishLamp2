//
//  NSObject+FLXmlObjectBuilder.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 5/7/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "NSObject+FLXmlObjectBuilder.h"
#import "FLParsedXmlElement.h"
#import "FLXmlObjectBuilder.h"
#import "FLObjectDescriber+FLXmlObjectBuilder.h"
#import "FLXmlParser.h"

@implementation NSObject (FLXmlObjectBuilder)
+ (id) objectWithXmlElement:(FLParsedXmlElement*) xmlElement 
          withObjectBuilder:(FLXmlObjectBuilder*) builder {

    FLAssertNotNil(builder);
    FLAssertNotNil(builder.decoder);
    FLAssertNotNil(xmlElement);

    FLObjectDescriber* objectDescriber = [self objectDescriber];
    return [objectDescriber xmlObjectBuilder:builder inflateRootObjectWithXML:xmlElement];
}


+ (id) objectWithXmlElement:(FLParsedXmlElement*) xmlElement 
                elementName:(NSString*) elementName
          withObjectBuilder:(FLXmlObjectBuilder*) builder {

    FLAssertNotNil(builder);
    FLAssertNotNil(builder.decoder);
    FLAssertNotNil(xmlElement);
    
    FLParsedXmlElement* buildElement = [builder findElementForBuilding:elementName inParentElement:xmlElement];
    
    return [self objectWithXmlElement:buildElement withObjectBuilder:builder];
                      
}          

+ (id) objectWithXmlFilePath:(NSString*) xmlFilePath {
    FLParsedXmlElement* xml = [[FLXmlParser xmlParser] parseFileAtPath:xmlFilePath];
    if(!xml) {
        return nil;
    }
    
    return [self objectWithXmlElement:xml 
                    withObjectBuilder:[FLXmlObjectBuilder xmlObjectBuilder]];
}

+ (id) objectWithXmlFile:(NSString*) xmlFileName inBundle:(NSBundle*) bundle {
    
    if(!bundle) {
        bundle = [NSBundle mainBundle];
    }
    
    NSString* pathToFile = [bundle pathForResource:[xmlFileName stringByDeletingPathExtension] ofType:[xmlFileName pathExtension]];
    
    FLConfirmNotNilWithComment(pathToFile, @"%@ not found in bundle", xmlFileName);
    
    return [self objectWithXmlFilePath:pathToFile];
}


@end

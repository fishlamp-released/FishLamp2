//
//  NSObject+FLXmlObjectBuilder.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 5/7/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FishLampCore.h"
@class FLParsedXmlElement;
@class FLXmlObjectBuilder;

@interface NSObject (FLXmlObjectBuilder)
+ (id) objectWithXmlElement:(FLParsedXmlElement*) xmlElement 
          withObjectBuilder:(FLXmlObjectBuilder*) builder;

+ (id) objectWithXmlElement:(FLParsedXmlElement*) xmlElement 
                elementName:(NSString*) elementName
          withObjectBuilder:(FLXmlObjectBuilder*) builder;

+ (id) objectWithXmlFilePath:(NSString*) xmlFilePath;

+ (id) objectWithXmlFile:(NSString*) xmlFileName inBundle:(NSBundle*) bundleOrNil;

@end

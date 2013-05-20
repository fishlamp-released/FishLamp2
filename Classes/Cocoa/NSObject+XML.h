//
//  NSObject+XML.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/30/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtPropertyDescription.h"

@class GtXmlParser;
@class GtObjectInflatorState;

#import "GtXmlBuilder.h"


@interface NSObject (XML)
- (BOOL) beginParsingFrom:(GtXmlParser*) parser state:(GtObjectInflatorState*) state;
- (void) finishParsingFrom:(GtXmlParser*) parser state:(GtObjectInflatorState*) state;

- (void) streamSelfToXmlBuilder:(GtXmlBuilder*) xmlBuilder propertyDescription:(GtPropertyDescription*) description;

+ (id) objectWithContentsOfFile:(NSString*) path;

@end


@interface GtXmlBuilder (NSObject)
- (void) addObjectAsXML:(id) object;
- (void) writeObjectToStream:(id) object propertyDescription:(GtPropertyDescription*) description;
- (void) addElementValueWithObject:(id) object	propertyDescription:(GtPropertyDescription*) description;
- (void) pushAttributeObject:(id) object attributeName:(NSString*)name propertyDescription:(GtPropertyDescription*) description;
- (void) addElementWithObjectValue:(id) object elementName:(NSString*) name propertyDescription:(GtPropertyDescription*) description;
@end
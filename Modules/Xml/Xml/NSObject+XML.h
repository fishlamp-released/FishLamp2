//
//  NSObject+XML.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/30/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"

#import "FLPropertyDescription.h"
#import "FLXmlBuilder.h"

@class FLXmlParser;
@class FLObjectInflatorState;


// Hey Art - 
// This is coupled to XML obviously. Maybe it doesn't need to be, e.g. it could 
// be refactored to not care what the parser is. But maybe XML vs Json are different enough
// that this wouldn't be worth it.

// The idea here is that subclasses know how to parse themselves when handed a parser in a
// specific state - e.g. everyone knows that we are the next object to be parsed from the stream.
// If not, it's an error. The FLObjectDescriber of the parent objects (in the xml document) knows what
// it's childen are.
//
// Note that this works ok but is problematic (and is kinda unfinished and a little rigid)
// For example, it dooesn't, but should, understand dictionaries or sets. It only can
// deal with arrays.

@interface NSObject (XML)
- (BOOL) beginParsingFrom:(FLXmlParser*) parser 
                    state:(FLObjectInflatorState*) state;

- (void) finishParsingFrom:(FLXmlParser*) parser 
                     state:(FLObjectInflatorState*) state;

- (void) streamSelfToXmlBuilder:(FLXmlBuilder*) xmlBuilder 
            propertyDescription:(FLPropertyDescription*) description;

+ (id) objectWithContentsOfFile:(NSString*) path;

@end

// this is a category that adds specific funtionality to the xml builder for serializing
// our dataobjects into xml. This is used by the soap/networking code to talk to 
// the webservices on iOS, etc.

@interface FLXmlBuilder (NSObject)
- (void) addObjectAsXML:(id) object;

- (void) writeObjectToStream:(id) object 
         propertyDescription:(FLPropertyDescription*) description;

- (void) appendElementValueWithObject:(id) object	
                  propertyDescription:(FLPropertyDescription*) description;

- (void) pushAttribute:(NSString*) attributeName 
                object:(id) object 
   propertyDescription:(FLPropertyDescription*) description;

- (void) appendElement:(NSString*) elementName 
                object:(id) object 
   propertyDescription:(FLPropertyDescription*) description;
@end
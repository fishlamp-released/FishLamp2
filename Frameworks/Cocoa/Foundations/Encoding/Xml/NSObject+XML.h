//
//  NSObject+XML.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/30/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"

@class FLXmlParser;
@class FLObjectInflatorState;

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

@interface NSObject (NSObjectXML)

- (BOOL) beginParsingFrom:(FLXmlParser*) parser 
                    state:(FLObjectInflatorState*) state;

- (void) finishParsingFrom:(FLXmlParser*) parser 
                     state:(FLObjectInflatorState*) state;


+ (id) objectWithContentsOfXMLFile:(NSString*) path;

@end



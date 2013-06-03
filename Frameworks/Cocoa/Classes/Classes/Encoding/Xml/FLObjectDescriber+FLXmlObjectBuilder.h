//
//  FLObjectDescriber+FLXmlObjectBuilder.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 5/7/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FishLamp.h"
#import "FLObjectDescriber.h"

@class FLXmlObjectBuilder;
@class FLParsedXmlElement;

@interface FLObjectDescriber (FLXmlObjectBuilder)

- (id) xmlObjectBuilder:(FLXmlObjectBuilder*) builder 
   inflateRootObjectWithXML:(FLParsedXmlElement*) element;
   
@end
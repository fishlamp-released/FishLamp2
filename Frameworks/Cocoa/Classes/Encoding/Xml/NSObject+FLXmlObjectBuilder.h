//
//  NSObject+FLXmlObjectBuilder.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 5/7/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FishLamp.h"
@class FLParsedItem;
@class FLXmlObjectBuilder;

@interface NSObject (FLXmlObjectBuilder)
+ (id) objectWithXmlElement:(FLParsedItem*) xmlElement 
          withObjectBuilder:(FLXmlObjectBuilder*) builder;

+ (id) objectWithXmlElement:(FLParsedItem*) xmlElement 
                elementName:(NSString*) elementName
          withObjectBuilder:(FLXmlObjectBuilder*) builder;

@end

//
//  FLPropertyDescriber+XmlObjectBuilder.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 5/7/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLPropertyDescriber.h"
@class FLXmlObjectBuilder;
@class FLParsedItem;

@interface FLPropertyDescriber (XmlObjectBuilder)
- (id) xmlObjectBuilder:(FLXmlObjectBuilder*) builder 
inflateObjectWithElement:(FLParsedItem*) element;

- (id) xmlObjectBuilder:(FLXmlObjectBuilder*) builder 
 inflateElementContents:(id) element;
@end

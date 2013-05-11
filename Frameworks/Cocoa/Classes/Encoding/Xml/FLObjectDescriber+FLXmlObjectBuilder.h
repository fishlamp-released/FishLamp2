//
//  FLObjectDescriber+FLXmlObjectBuilder.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 5/7/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FishLamp.h"
#import "FLObjectDescriber.h"

@class FLXmlObjectBuilder;
@class FLParsedItem;

@interface FLObjectDescriber (FLXmlObjectBuilder)

- (id) xmlObjectBuilder:(FLXmlObjectBuilder*) builder 
   inflateRootObjectWithXML:(FLParsedItem*) element;
   
@end
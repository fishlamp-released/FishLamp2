//
//  NSObject+FLXmlSerialization.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/29/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLXmlDocumentBuilder.h"
#import "FLStringEncoder.h"
#import "FLModelObject.h"

@interface FLStringEncoder (FLXmlSerialization)
- (void) addToXmlElement:(FLXmlElement*) xmlElement
                typeDesc:(FLObjectDescriber*) description
                   value:(id) value;
@end

@interface NSArray (FLXmlSerialization)
@end


@interface NSObject (FLXmlSerialization)
@end

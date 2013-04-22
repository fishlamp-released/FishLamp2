//
//  NSObject+FLXmlSerialization.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLXmlDocumentBuilder.h"
#import "FLObjectEncoder.h"
#import "FLCoreTypes.h"
#import "FLModelObject.h"

@interface FLObjectEncoder (FLXmlSerialization)
- (void) addToXmlElement:(FLXmlElement*) xmlElement
                typeDesc:(FLObjectDescriber*) description
                   value:(id) value;
@end

@interface NSArray (FLXmlSerialization)
@end


@interface NSObject (FLXmlSerialization)
@end

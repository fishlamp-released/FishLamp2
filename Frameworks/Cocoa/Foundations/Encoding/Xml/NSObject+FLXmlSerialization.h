//
//  NSObject+FLXmlSerialization.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLXmlDocumentBuilder.h"
#import "FLType.h"
#import "FLCoreTypes.h"

@interface FLType (FLXmlSerialization)
- (void) addToXmlElement:(FLXmlElement*) xmlElement
     propertyType:(FLPropertyType*) description
                   value:(id) value;
@end

@interface NSArray (FLXmlSerialization)
@end


@interface NSObject (FLXmlSerialization)
@end

//
//  FLPropertyDescriber+XmlObjectBuilder.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 5/7/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLPropertyDescriber+XmlObjectBuilder.h"
#import "FLXmlObjectBuilder.h"
#import "FLParsedItem.h"
#import "FLModelObject.h"
#import "NSArray+FLXmlObjectBuilder.h"
#import "FLDataEncoder.h"
#import "FLObjectDescriber+FLXmlObjectBuilder.h"

@implementation FLPropertyDescriber (XmlObjectBuilder)
- (id) xmlObjectBuilder:(FLXmlObjectBuilder*) builder 
inflateObjectWithElement:(FLParsedItem*) element {
    
    if(FLStringIsNotEmpty([element value])) {
        id<FLStringEncoder> encoder = [self objectEncoder];

        FLAssertNotNilWithComment(encoder, @"no encoder found for property: %@", self.propertyName);

        if(encoder) {
            id object = [builder.decoder decodeDataFromString:[element value] forType:encoder];
            
            FLAssertNotNilWithComment(object,
                    @"object not expanded for %@:%@", [element elementName], [element value]);
            
            return object;
        }
    }
    return nil;
}
- (id) xmlObjectBuilder:(FLXmlObjectBuilder*) builder 
 inflateElementContents:(id) element {

    FLAssert([element isKindOfClass:[FLParsedItem class]]);

    return [self xmlObjectBuilder:builder inflateObjectWithElement:element];
}

@end

//@implementation FLObjectPropertyDescriber (FLXmlObjectBuilder) 
//
//- (id) xmlObjectBuilder:(FLXmlObjectBuilder*) builder 
// inflateElementContents:(id) element {
//
//    FLAssert([element isKindOfClass:[FLParsedItem class]]);
//
//    return [self xmlObjectBuilder:builder inflateObjectWithElement:element];
//}
//
//
//@end

@implementation FLModelObjectPropertyDescriber (FLXmlObjectBuilder)

- (id) xmlObjectBuilder:(FLXmlObjectBuilder*) builder 
inflateObjectWithElement:(FLParsedItem*) item {
    return [self.representedObjectClass objectWithXmlElement:item withObjectBuilder:builder];
}

@end

@implementation FLArrayPropertyDescriber (FLXmlObjectBuilder) 

- (id) xmlObjectBuilder:(FLXmlObjectBuilder*) builder 
 inflateElementContents:(id) contents {
    return [contents xmlObjectBuilder:builder arrayWithElementContents:self];
}

@end
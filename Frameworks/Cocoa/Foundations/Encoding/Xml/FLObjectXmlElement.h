//
//  FLObjectXmlElement.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLXmlElement.h"
#import "FLPropertyType.h"

@interface FLObjectXmlElement : FLXmlElement {
@private
    id _object;
    FLPropertyType* _propertyType;
}

- (id) initWithObject:(id) object 
        xmlElementTag:(NSString*) xmlElementTag;

+ (id) objectXmlElement:(id) object 
          xmlElementTag:(NSString*) xmlElementTag;

+ (id) objectXmlElement:(id) object 
          xmlElementTag:(NSString*) xmlElementTag
          propertyType:(FLPropertyType*) description;

@end

@protocol FLXMLSeriliazable <NSObject>
- (void) addToXmlElement:(FLXmlElement*) xmlElement
     propertyType:(FLPropertyType*) description;
@end


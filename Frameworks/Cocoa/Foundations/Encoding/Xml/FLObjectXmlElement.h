//
//  FLObjectXmlElement.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLXmlElement.h"
#import "FLPropertyDescription.h"

@interface FLObjectXmlElement : FLXmlElement {
@private
    id _object;
    FLPropertyDescription* _propertyDescription;
}

- (id) initWithObject:(id) object 
        xmlElementTag:(NSString*) xmlElementTag;

+ (id) objectXmlElement:(id) object 
          xmlElementTag:(NSString*) xmlElementTag;

+ (id) objectXmlElement:(id) object 
          xmlElementTag:(NSString*) xmlElementTag
          propertyDescription:(FLPropertyDescription*) description;

@end

@protocol FLXMLSeriliazable <NSObject>
- (void) addToXmlElement:(FLXmlElement*) xmlElement
     propertyDescription:(FLPropertyDescription*) description;
@end


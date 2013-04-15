//
//  FLObjectXmlElement.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLXmlElement.h"
#import "FLObjectDescriber.h"

@interface FLObjectXmlElement : FLXmlElement {
@private
    id _object;
    FLTypeDesc* _objectTypeDesc;
}

- (id) initWithObject:(id) object 
        xmlElementTag:(NSString*) xmlElementTag;

+ (id) objectXmlElement:(id) object 
          xmlElementTag:(NSString*) xmlElementTag;

+ (id) objectXmlElement:(id) object 
          xmlElementTag:(NSString*) xmlElementTag
               typeDesc:(FLTypeDesc*) description;

@end

@protocol FLXMLSeriliazable <NSObject>
- (void) addToXmlElement:(FLXmlElement*) xmlElement
                typeDesc:(FLTypeDesc*) typeDesc;
@end


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
    FLObjectDescriber* _xmlObjectDescriber;
}

- (id) initWithObject:(id) object 
        xmlElementTag:(NSString*) xmlElementTag;

+ (id) objectXmlElement:(id) object 
          xmlElementTag:(NSString*) xmlElementTag;

+ (id) objectXmlElement:(id) object 
          xmlElementTag:(NSString*) xmlElementTag
          objectDescriber:(FLObjectDescriber*) description;

@end

@protocol FLXMLSeriliazable <NSObject>
- (void) addToXmlElement:(FLXmlElement*) xmlElement
     objectDescriber:(FLObjectDescriber*) description;
@end


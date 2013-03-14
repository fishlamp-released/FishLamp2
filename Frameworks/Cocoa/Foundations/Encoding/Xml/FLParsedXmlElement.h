//
//  FLParsedXmlElement.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/13/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"

@interface FLParsedXmlElement : NSObject {
@private
    NSDictionary* _attributes;
    NSString* _namespace;
    NSString* _elementName;
    NSString* _qualifiedName;
    NSMutableString* _value;
    NSMutableDictionary* _elements;
    __unsafe_unretained FLParsedXmlElement* _parent;
}
+ (id) parsedXmlElement;

@property (readwrite, strong, nonatomic) NSDictionary* attributes;
@property (readwrite, strong, nonatomic) NSString* namespaceURI;
@property (readwrite, strong, nonatomic) NSString* elementName;
@property (readwrite, strong, nonatomic) NSString* qualifiedName;
@property (readonly, strong, nonatomic) NSString* value;
@property (readonly, strong, nonatomic) NSDictionary* elements;
@property (readonly, assign, nonatomic) FLParsedXmlElement* parent;

- (void) appendStringToValue:(NSString*) string;
- (void) addElement:(FLParsedXmlElement*) element;

- (FLParsedXmlElement*) elementAtPath:(NSString*) path;
- (FLParsedXmlElement*) elementForElementName:(NSString*) name;
- (NSDictionary*) childrenAtPath:(NSString*) parentalPath;

@end
//
//  FLParsedXmlElement.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/13/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaRequired.h"

@interface FLParsedXmlElement : NSObject {
@private
    NSDictionary* _attributes;
    NSString* _namespace;
    NSString* _elementName;
    NSString* _qualifiedName;
    NSMutableString* _elementValue;
    NSMutableDictionary* _elements;
    FLParsedXmlElement* _sibling;
    NSString* _prefix;
    NSString* _mappedToNamespace;

    __unsafe_unretained FLParsedXmlElement* _parent;
}
- (id) initWithName:(NSString*) name elementValue:(NSString*) elementValue;

+ (id) parsedXmlElement;
+ (id) parsedXmlElement:(NSString*) name elementValue:(NSString*) elementValue;

@property (readwrite, strong, nonatomic) NSDictionary* attributes;
@property (readwrite, strong, nonatomic) NSString* namespaceURI;
@property (readwrite, strong, nonatomic) NSString* qualifiedName;
@property (readwrite, strong, nonatomic) NSString* elementName;
@property (readwrite, strong, nonatomic) NSString* elementValue;
@property (readonly, strong, nonatomic) NSString* prefix;
@property (readonly, assign, nonatomic) BOOL isQualified;
@property (readonly, strong, nonatomic) NSString* targetNamespace;
@property (readonly, strong, nonatomic) NSString* fullPath;

- (void) appendStringToValue:(NSString*) string;

// parent
@property (readonly, assign, nonatomic) FLParsedXmlElement* parent;

// siblings
@property (readwrite, strong, nonatomic) FLParsedXmlElement* sibling;
@property (readonly, assign, nonatomic) NSUInteger siblingCount;

// childElements 
@property (readonly, strong, nonatomic) NSDictionary* childElements;
- (void) addChildElement:(FLParsedXmlElement*) element;
- (FLParsedXmlElement*) childElementAtPath:(NSString*) path;
- (FLParsedXmlElement*) childElementForName:(NSString*) name;
- (FLParsedXmlElement*) findChildElementWithName:(NSString*) name 
                                      maxDepth:(NSInteger) maxDepth;

//- (NSDictionary*) childrenAtPath:(NSString*) parentalPath;

- (void) describeToStringFormatter:(id<FLStringFormatter>) stringFormatter;

@end

//@interface FLParsedItemIterator : NSObject {
//@private
//    FLParsedXmlElement* _item;
//    FLParsedXmlElement* _top;
//}
//
//@property (readonly, strong, nonatomic) FLParsedXmlElement* item;
//
//- (void) openItem:(NSString*) name;
//- (void) closeItem;
//
//
//@end

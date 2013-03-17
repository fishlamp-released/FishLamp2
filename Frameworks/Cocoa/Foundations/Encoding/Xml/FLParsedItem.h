//
//  FLParsedItem.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/13/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"

@interface FLParsedItem : NSObject {
@private
    NSDictionary* _attributes;
    NSString* _namespace;
    NSString* _elementName;
    NSString* _qualifiedName;
    NSMutableString* _value;
    NSMutableDictionary* _elements;
    __unsafe_unretained FLParsedItem* _parent;
}

+ (id) parsedItem;

@property (readwrite, strong, nonatomic) NSDictionary* attributes;
@property (readwrite, strong, nonatomic) NSString* namespaceURI;
@property (readwrite, strong, nonatomic) NSString* qualifiedName;

@property (readwrite, strong, nonatomic) NSString* elementName;

@property (readonly, strong, nonatomic) NSString* value;

@property (readonly, strong, nonatomic) NSDictionary* elements;

@property (readonly, assign, nonatomic) FLParsedItem* parent;

- (void) appendStringToValue:(NSString*) string;

- (void) addElement:(FLParsedItem*) element;

- (FLParsedItem*) elementAtPath:(NSString*) path;
- (FLParsedItem*) elementForElementName:(NSString*) name;

- (NSDictionary*) childrenAtPath:(NSString*) parentalPath;

@end

//@interface FLParsedItemIterator : NSObject {
//@private
//    FLParsedItem* _item;
//    FLParsedItem* _top;
//}
//
//@property (readonly, strong, nonatomic) FLParsedItem* item;
//
//- (void) openItem:(NSString*) name;
//- (void) closeItem;
//
//
//@end

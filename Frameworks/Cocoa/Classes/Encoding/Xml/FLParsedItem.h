//
//  FLParsedItem.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/13/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaRequired.h"

@interface FLParsedItem : NSObject {
@private
    NSDictionary* _attributes;
    NSString* _namespace;
    NSString* _elementName;
    NSString* _qualifiedName;
<<<<<<< HEAD
    NSMutableString* _elementValue;
    NSMutableDictionary* _elements;
    __unsafe_unretained FLParsedItem* _parent;
}
- (id) initWithName:(NSString*) name elementValue:(NSString*) elementValue;

+ (id) parsedItem;
+ (id) parsedItem:(NSString*) name elementValue:(NSString*) elementValue;
=======
    NSMutableString* _value;
    NSMutableDictionary* _elements;
    __unsafe_unretained FLParsedItem* _parent;
}
- (id) initWithName:(NSString*) name value:(NSString*) value;

+ (id) parsedItem;
+ (id) parsedItem:(NSString*) name value:(NSString*) value;
>>>>>>> 9adc319f4c693a0ff3e18af8c127f2216cc01a3b

@property (readwrite, strong, nonatomic) NSDictionary* attributes;
@property (readwrite, strong, nonatomic) NSString* namespaceURI;
@property (readwrite, strong, nonatomic) NSString* qualifiedName;

@property (readwrite, strong, nonatomic) NSString* elementName;

<<<<<<< HEAD
@property (readonly, strong, nonatomic) NSString* elementValue;
=======
@property (readonly, strong, nonatomic) NSString* value;
>>>>>>> 9adc319f4c693a0ff3e18af8c127f2216cc01a3b

@property (readonly, strong, nonatomic) NSDictionary* elements;

@property (readonly, assign, nonatomic) FLParsedItem* parent;

- (void) appendStringToValue:(NSString*) string;

- (void) addElement:(FLParsedItem*) element;

<<<<<<< HEAD
- (NSArray*) elementsAtPath:(NSString*) path;
- (NSArray*) elementsForElementName:(NSString*) name;
//- (id) findElementWithName:(NSString*) name maxDepth:(NSInteger) maxDepth;
=======
- (FLParsedItem*) elementAtPath:(NSString*) path;
- (FLParsedItem*) elementForElementName:(NSString*) name;
- (FLParsedItem*) findElementWithName:(NSString*) name maxDepth:(NSInteger) maxDepth;
>>>>>>> 9adc319f4c693a0ff3e18af8c127f2216cc01a3b

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

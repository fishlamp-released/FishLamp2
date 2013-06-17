//
//  FLParsedXmlElement.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/13/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLParsedXmlElement.h"

@interface FLParsedXmlElement ()
@property (readwrite, assign, nonatomic) FLParsedXmlElement* parent;
@property (readwrite, strong, nonatomic) NSString* prefix;

@end

@implementation FLParsedXmlElement

@synthesize attributes = _attributes;
@synthesize namespaceURI = _namespace;
@synthesize elementName = _elementName;
@synthesize qualifiedName = _qualifiedName;
@synthesize elementValue = _elementValue;
@synthesize childElements = _elements;
@synthesize parent = _parent;
@synthesize sibling = _sibling;
@synthesize prefix = _prefix;

- (id) initWithName:(NSString*) name elementValue:(NSString*) elementValue {	
	self = [super init];
	if(self) {
		self.elementName = name;
        _elementValue = [elementValue mutableCopy];
	}
	return self;
}

+ (id) parsedXmlElement {
    return FLAutorelease([[[self class] alloc] init]);
}

+ (id) parsedXmlElement:(NSString*) name elementValue:(NSString*) elementValue {
    return FLAutorelease([[[self class] alloc] initWithName:name elementValue:elementValue]);
}

- (void) setElementValue:(NSString*) string {
    FLSetObjectWithMutableCopy(_elementValue, string);
}

- (void) appendStringToValue:(NSString*) string {
    if(FLStringIsNotEmpty(string)) {
        if(_elementValue) {
            [_elementValue appendString:string];
        }
        else {
            _elementValue = [string mutableCopy];
        }
    }
}

- (void) addSibling:(FLParsedXmlElement*) sibling {
    FLParsedXmlElement* walker = self;
    while(walker.sibling) {
        walker = walker.sibling;
    }
    FLAssertNotNil(walker);
    FLAssertIsNil(walker.sibling);
    walker.sibling = sibling;
}

- (void) addChildElement:(FLParsedXmlElement*) element {
    if(!_elements) {
        _elements = [[NSMutableDictionary alloc] init];
    }
    element.parent = self;

    FLParsedXmlElement* current = [_elements objectForKey:element.elementName];
    if(current) {
        [current addSibling:element];
    }
    else {
        [_elements setObject:element forKey:element.elementName];
    }
}

- (FLParsedXmlElement*) childElementForName:(NSString*) name {
    return [_elements objectForKey:name];
}

#if FL_MRC
- (void) dealloc {
    [_prefix release];
    [_sibling release];
    [_attributes release];
    [_namespace release];
    [_elementName release];
    [_qualifiedName release];
    [_elementValue release];
    [_elements release];
    [super dealloc];
}
#endif

- (FLParsedXmlElement*) findChildElementWithName:(NSString*) name maxDepth:(NSInteger) maxDepth {
    FLParsedXmlElement* item = [_elements objectForKey:name];
    if(item) {
        return item;
    }

    if(maxDepth > 0) {
        maxDepth--;
        
        for(FLParsedXmlElement* childElement in [_elements objectEnumerator]) {
            FLParsedXmlElement* found = [childElement findChildElementWithName:name maxDepth:maxDepth];
            if(found) {
                return found;
            }
        }
    }
    
    return nil;
}

- (FLParsedXmlElement*) childElementAtPath:(NSString*) path {
    FLParsedXmlElement* obj = self;
    NSArray* pathComponents = [path pathComponents];
    for(NSString* component in pathComponents) {
        obj = [obj childElementForName:component];
    }
    return obj;
}

//- (NSDictionary*) childrenAtPath:(NSString*) parentalPath {
//    return [[self elementAtPath:parentalPath] childElement];
//}

- (void) describeToStringFormatter:(id<FLStringFormatter>) stringFormatter {
    [stringFormatter appendFormat:@"<%@", self.elementName];
    if(FLStringIsNotEmpty(self.namespaceURI)) {
        [stringFormatter appendFormat:@" %@=\"%@\"", @"namespace", self.namespaceURI];
    }
    if(FLStringIsNotEmpty(self.qualifiedName)) {
        [stringFormatter appendFormat:@" %@=\"%@\"", @"qualifiedName", self.qualifiedName];
    }
    for(NSString* attr in self.attributes) {
        [stringFormatter appendFormat:@" %@=\"%@\"", attr, [self.attributes objectForKey:attr]];
    }
    [stringFormatter appendLine:@">"];
    [stringFormatter indent:^{
        if(FLStringIsNotEmpty(self.elementValue)) {
            [stringFormatter appendLineWithFormat:@"%@", self.elementValue];
        }
        for(FLParsedXmlElement* element in [self.childElements objectEnumerator]) {
            [element describeToStringFormatter:stringFormatter];
        }
    }];

    [stringFormatter appendLineWithFormat:@"</%@>", self.elementName];

    [stringFormatter appendLineWithFormat:@"<!-- %d siblings -->", self.siblingCount];
}

- (BOOL) isQualified {
    return FLStringsAreEqual(@"qualified", [_attributes objectForKey:@"elementFormDefault"]);
}

- (NSString*) targetNamespace {
    return [_attributes objectForKey:@"targetNamespace"];
}

- (NSString*) prefix {
    if(!_prefix) {
        _prefix = @"";
        for(NSInteger i = 0; i < _qualifiedName.length; i++) {
            if([_qualifiedName characterAtIndex:i] == ':') {
                self.prefix = [_qualifiedName substringToIndex:i];
                break;
            }
        }
        
    }
    
    return _prefix;
}
- (NSString*) description {

    FLPrettyString* prettyString = [FLPrettyString prettyString];
    [self describeToStringFormatter:prettyString];
    return prettyString.string;

//    return [NSString stringWithFormat:@"elementName:%@, namespace:%@, qualifiedName:%@, attributes:%@, elementValue:%@, elements:%@ \n",
//        FLEmptyStringOrString(self.elementName),
//        FLEmptyStringOrString(self.namespaceURI),
//        FLEmptyStringOrString(self.qualifiedName),
//        FLEmptyStringOrString([self.attributes description]),
//        FLEmptyStringOrString(self.elementValue),
//        FLEmptyStringOrString([self.elements description])
//    ];
}

- (NSUInteger) siblingCount {
    NSUInteger count = 0;
    FLParsedXmlElement* walker = self;
    while(walker.sibling) {
        walker = walker.sibling;
        
        ++count;
    }
    
    return count;
}

- (void) appendFullPath:(NSMutableString*) path {
    if(self.parent) {
        [self.parent appendFullPath:path];
    }

    [path appendFormat:@"<%@>", self.elementName];
}

- (NSString*) fullPath {
    NSMutableString* fullPath = [NSMutableString string];
    [self appendFullPath:fullPath];
    return fullPath;
}

@end

////
////  FLParsedXmlElement.m
////  FishLampCocoa
////
////  Created by Mike Fullerton on 3/13/13.
////  Copyright (c) 2013 Mike Fullerton. All rights reserved.
////
//
//#import "FLParsedXmlElement.h"
//
//@interface FLParsedXmlElement ()
//@property (readwrite, assign, nonatomic) FLParsedXmlElement* parent;
//
//@end
//
//@implementation FLParsedXmlElement
//
//@synthesize attributes = _attributes;
//@synthesize namespaceURI = _namespace;
//@synthesize elementName = _elementName;
//@synthesize qualifiedName = _qualifiedName;
//@synthesize value = _elementValue;
//@synthesize elements = _elements;
//@synthesize parent = _parent;
//
//- (id) initWithName:(NSString*) name value:(NSString*) value {	
//	self = [super init];
//	if(self) {
//		self.elementName = name;
//        _elementValue = [value mutableCopy];
//	}
//	return self;
//}
//
//+ (id) parsedXmlElement {
//    return FLAutorelease([[[self class] alloc] init]);
//}
//
//+ (id) parsedXmlElement:(NSString*) name value:(NSString*) value {
//    return FLAutorelease([[[self class] alloc] initWithName:name value:value]);
//}
//
//- (void) appendStringToValue:(NSString*) string {
//    if(FLStringIsNotEmpty(string)) {
//        if(_elementValue) {
//            [_elementValue appendString:string];
//        }
//        else {
//            _elementValue = [string mutableCopy];
//        }
//    }
//}
//
//- (void) addElement:(FLParsedXmlElement*) element {
//    if(!_elements) {
//        _elements = [[NSMutableDictionary alloc] init];
//    }
//    id existing = [_elements objectForKey:element.elementName];
//    if(!existing) {
//        [_elements setObject:element forKey:element.elementName];
//    }
//    else if([existing isKindOfClass:[NSMutableArray class]]) {
//        [((NSMutableArray*)existing) addObject:element];
//    }
//    else {
//        NSMutableArray* array = [NSMutableArray arrayWithObjects:existing, element, nil];
//        [_elements setObject:array forKey:element.elementName];
//    }
//    element.parent = self;
//}
//
//- (FLParsedXmlElement*) elementForElementName:(NSString*) name {
//    return [_elements objectForKey:name];
//}
//
//#if FL_MRC
//- (void) dealloc {
//    [_attributes release];
//    [_namespace release];
//    [_elementName release];
//    [_qualifiedName release];
//    [_elementValue release];
//    [_elements release];
//    [super dealloc];
//}
//#endif
//
//- (FLParsedXmlElement*) findElementWithName:(NSString*) name maxDepth:(NSInteger) maxDepth {
//    FLParsedXmlElement* item = [_elements objectForKey:name];
//    if(item) {
//        return item;
//    }
//
//    if(maxDepth > 0) {
//        maxDepth--;
//        
//        for(FLParsedXmlElement* childElement in [_elements objectEnumerator]) {
//            FLParsedXmlElement* found = [childElement findElementWithName:name maxDepth:maxDepth];
//            if(found) {
//                return found;
//            }
//        }
//    }
//    
//    return nil;
//}
//
//- (FLParsedXmlElement*) elementAtPath:(NSString*) path {
//    FLParsedXmlElement* obj = self;
//    NSArray* pathComponents = [path pathComponents];
//    for(NSString* component in pathComponents) {
//        obj = [obj elementForElementName:component];
//    }
//    return obj;
//}
//
//- (NSDictionary*) childrenAtPath:(NSString*) parentalPath {
//    return [[self elementAtPath:parentalPath] elements];
//}
//
//- (NSString*) description {
//
//    return [NSString stringWithFormat:@"elementName:%@, namespace:%@, qualifiedName:%@, attributes:%@, value:%@, elements:%@ \n",
//        FLEmptyStringOrString(self.elementName),
//        FLEmptyStringOrString(self.namespaceURI),
//        FLEmptyStringOrString(self.qualifiedName),
//        FLEmptyStringOrString([self.attributes description]),
//        FLEmptyStringOrString(self.value),
//        FLEmptyStringOrString([self.elements description])
//    ];
//}
//
//@end

//
//  FLParsedItem.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/13/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLParsedItem.h"

@interface FLParsedItem ()
@property (readwrite, assign, nonatomic) FLParsedItem* parent;

@end

@implementation FLParsedItem

@synthesize attributes = _attributes;
@synthesize namespaceURI = _namespace;
@synthesize elementName = _elementName;
@synthesize qualifiedName = _qualifiedName;
@synthesize elementValue = _elementValue;
@synthesize elements = _elements;
@synthesize parent = _parent;

- (id) initWithName:(NSString*) name elementValue:(NSString*) elementValue {	
	self = [super init];
	if(self) {
		self.elementName = name;
        _elementValue = [elementValue mutableCopy];
	}
	return self;
}

+ (id) parsedItem {
    return FLAutorelease([[[self class] alloc] init]);
}

+ (id) parsedItem:(NSString*) name elementValue:(NSString*) elementValue {
    return FLAutorelease([[[self class] alloc] initWithName:name elementValue:elementValue]);
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

- (void) addElement:(FLParsedItem*) element {
    if(!_elements) {
        _elements = [[NSMutableDictionary alloc] init];
    }
    NSArray* existing = [_elements objectForKey:element.elementName];
    if(!existing) {
        [_elements setObject:[NSMutableArray arrayWithObject:element] forKey:element.elementName];
    }
    else if([existing isKindOfClass:[NSMutableArray class]]) {
        [((NSMutableArray*)existing) addObject:element];
    }
//    else {
//        NSMutableArray* array = [NSMutableArray arrayWithObjects:existing, element, nil];
//        [_elements setObject:array forKey:element.elementName];
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
    element.parent = self;
}

- (NSArray*) elementForElementName:(NSString*) name {
    return [_elements objectForKey:name];
}

#if FL_MRC
- (void) dealloc {
    [_attributes release];
    [_namespace release];
    [_elementName release];
    [_qualifiedName release];
    [_elementValue release];
    [_elements release];
    [super dealloc];
}
#endif

- (NSArray*) findElementWithName:(NSString*) name maxDepth:(NSInteger) maxDepth {
    NSArray* item = [_elements objectForKey:name];
    if(item) {
        return item;
    }

    if(maxDepth > 0) {
        maxDepth--;
        
        for(FLParsedItem* subElement in [_elements objectEnumerator]) {
            NSArray* found = [subElement findElementWithName:name maxDepth:maxDepth];
            if(found) {
                return found;
            }
        }
    }
    
    return nil;
}

- (NSArray*) elementsAtPath:(NSString*) path {
    NSArray* obj = self;
    NSArray* pathComponents = [path pathComponents];
    for(NSString* component in pathComponents) {
        obj = [obj elementForElementName:component];
    }
    return obj;
}

- (NSDictionary*) childrenAtPath:(NSString*) parentalPath {
    return [[self elementAtPath:parentalPath] elements];
}

- (void) prettyDescription:(FLPrettyString*) description {
    [description appendFormat:@"<%@", self.elementName];
    if(FLStringIsNotEmpty(self.namespaceURI)) {
        [description appendFormat:@" namespace=\"%@\"", self.namespaceURI];
    }
    if(FLStringIsNotEmpty(self.qualifiedName)) {
        [description appendFormat:@" qualifiedName=\"%@\"", self.qualifiedName];
    }

    for(NSString* attribute in self.attributes) {
        [description appendFormat:@" %@=\"%@\"", attribute, [self.attributes objectForKey:attribute]];
    }
    [description appendLine:@">"];
    
    [description indent];
        if(FLStringIsNotEmpty(self.elementValue)) {
            [description appendLine:self.elementValue];
        }
        for(NSString* elementID in _elements) {
            NSArray* elements = [_elements objectForKey:elementID];
            for(FLParsedItem* item in elements) {
                [item prettyDescription:description];
            }
        }
    [description outdent];
    [description appendLineWithFormat:@"</%@>", self.elementName];
} 

- (NSString*) description {

    FLPrettyString* string = [FLPrettyString prettyString];
    [self prettyDescription:string];
    return string.string;

//    return [NSString stringWithFormat:@"elementName:%@, namespace:%@, qualifiedName:%@, attributes:%@, value:%@, elements:%@ \n",
//        FLEmptyStringOrString(self.elementName),
//        FLEmptyStringOrString(self.namespaceURI),
//        FLEmptyStringOrString(self.qualifiedName),
//        FLEmptyStringOrString([self.attributes description]),
//        FLEmptyStringOrString(self.value),
//        FLEmptyStringOrString([self.elements description])
//    ];
}



@end

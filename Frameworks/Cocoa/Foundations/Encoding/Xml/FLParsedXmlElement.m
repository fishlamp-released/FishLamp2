//
//  FLParsedXmlElement.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/13/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLParsedXmlElement.h"

@interface FLParsedXmlElement ()
@property (readwrite, assign, nonatomic) FLParsedXmlElement* parent;

@end

@implementation FLParsedXmlElement

@synthesize attributes = _attributes;
@synthesize namespaceURI = _namespace;
@synthesize elementName = _elementName;
@synthesize qualifiedName = _qualifiedName;
@synthesize value = _value;
@synthesize elements = _elements;
@synthesize parent = _parent;

+ (id) parsedXmlElement {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) appendStringToValue:(NSString*) string {
    string = [string trimmedString];
    if(FLStringIsNotEmpty(string)) {
        if(_value) {
            [_value appendString:string];
        }
        else {
            _value = [string mutableCopy];
        }
    }
}

- (void) addElement:(FLParsedXmlElement*) element {
    if(!_elements) {
        _elements = [[NSMutableDictionary alloc] init];
    }
    id existing = [_elements objectForKey:element.elementName];
    if(!existing) {
        [_elements setObject:element forKey:element.elementName];
    }
    else if([existing isKindOfClass:[NSMutableArray class]]) {
        [existing addObject:element];
    }
    else {
        NSMutableArray* array = [NSMutableArray arrayWithObjects:existing, element, nil];
        [_elements setObject:array forKey:element.elementName];
    }
    element.parent = self;
}

- (FLParsedXmlElement*) elementForElementName:(NSString*) name {
    return [_elements objectForKey:name];
}

#if FL_MRC
- (void) dealloc {
    [_attributes release];
    [_namespace release];
    [_elementName release];
    [_qualifiedName release];
    [_value release];
    [_elements release];
    [super dealloc];
}
#endif

- (FLParsedXmlElement*) elementAtPath:(NSString*) path {
    FLParsedXmlElement* obj = self;
    NSArray* pathComponents = [path pathComponents];
    for(NSString* component in pathComponents) {
        obj = [obj elementForElementName:component];
    }
    return obj;
}

- (NSDictionary*) childrenAtPath:(NSString*) parentalPath {
    return [[self elementAtPath:parentalPath] elements];
}

- (NSString*) description {

    return [NSString stringWithFormat:@"elementName:%@, namespace:%@, qualifiedName:%@, attributes:%@, value:%@, elements:%@ \n",
        FLEmptyStringOrString(self.elementName),
        FLEmptyStringOrString(self.namespaceURI),
        FLEmptyStringOrString(self.qualifiedName),
        FLEmptyStringOrString([self.attributes description]),
        FLEmptyStringOrString(self.value),
        FLEmptyStringOrString([self.elements description])
    ];
}

@end

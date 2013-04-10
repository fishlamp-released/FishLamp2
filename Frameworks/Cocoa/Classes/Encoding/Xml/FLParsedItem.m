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
@synthesize value = _value;
@synthesize elements = _elements;
@synthesize parent = _parent;

- (id) initWithName:(NSString*) name value:(NSString*) value {	
	self = [super init];
	if(self) {
		self.elementName = name;
        _value = [value mutableCopy];
	}
	return self;
}

+ (id) parsedItem {
    return FLAutorelease([[[self class] alloc] init]);
}

+ (id) parsedItem:(NSString*) name value:(NSString*) value {
    return FLAutorelease([[[self class] alloc] initWithName:name value:value]);
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

- (void) addElement:(FLParsedItem*) element {
    if(!_elements) {
        _elements = [[NSMutableDictionary alloc] init];
    }
    id existing = [_elements objectForKey:element.elementName];
    if(!existing) {
        [_elements setObject:element forKey:element.elementName];
    }
    else if([existing isKindOfClass:[NSMutableArray class]]) {
        [((NSMutableArray*)existing) addObject:element];
    }
    else {
        NSMutableArray* array = [NSMutableArray arrayWithObjects:existing, element, nil];
        [_elements setObject:array forKey:element.elementName];
    }
    element.parent = self;
}

- (FLParsedItem*) elementForElementName:(NSString*) name {
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

- (FLParsedItem*) findElementWithName:(NSString*) name maxDepth:(NSInteger) maxDepth {
    FLParsedItem* item = [_elements objectForKey:name];
    if(item) {
        return item;
    }

    if(maxDepth > 0) {
        maxDepth--;
        
        for(FLParsedItem* subElement in [_elements objectEnumerator]) {
            FLParsedItem* found = [subElement findElementWithName:name maxDepth:maxDepth];
            if(found) {
                return found;
            }
        }
    }
    
    return nil;
}

- (FLParsedItem*) elementAtPath:(NSString*) path {
    FLParsedItem* obj = self;
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

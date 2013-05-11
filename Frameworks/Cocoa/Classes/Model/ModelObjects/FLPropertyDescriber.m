//
//  FLPropertyDescriber.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/22/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLPropertyDescriber.h"
#import "FLObjectDescriber.h"
#import "FLPropertyAttributes.h"
#import "FLModelObject.h"

@implementation NSObject (FLXmlBuilder)
+ (id) propertyDescriber {
    return [FLObjectPropertyDescriber propertyDescriber];
}
@end

@implementation NSArray (FLXmlBuilder)
+ (id) propertyDescriber {
    return [FLArrayPropertyDescriber propertyDescriber];
}
@end

#define LazyStringGetter(name, ivar, char_string) \
- (NSString*) name { \
    if(!ivar) { \
        ivar = [NSString stringWithCharString:char_string]; \
    } \
    return ivar; \
}

#define LazySelectorGetter(name, ivar, char_string) \
- (SEL) name { \
    if(!ivar) { \
        ivar = NSSelectorFromString([NSString stringWithCharString:char_string]); \
    } \
    return ivar; \
}

@interface FLPropertyDescriber ()
@property (readwrite, strong) NSString* propertyName;
@property (readwrite, strong) FLObjectDescriber* representedObjectDescriber;
@property (readwrite, strong) NSArray* containedTypes;
@property (readwrite, assign) FLPropertyAttributes_t attributes;

+ (id) propertyDescriberWithProperty_t:(objc_property_t) property_t;
- (void) addContainedProperty:(NSString*) name withClass:(Class) aClass; 

@end


@implementation FLPropertyDescriber
@synthesize propertyName = _propertyName;
@synthesize representedObjectDescriber = _representedObjectDescriber;
@synthesize containedTypes = _containedTypes;

LazyStringGetter(structName, _structName, _attributes.structName)
LazyStringGetter(unionName, _unionName, _attributes.unionName)
LazyStringGetter(ivarName, _ivarName, _attributes.ivar)

LazySelectorGetter(customGetter, _customGetter, _attributes.customGetter)
LazySelectorGetter(customSetter, _customSetter, _attributes.customSetter)
LazySelectorGetter(selector, _selector, _attributes.selector)

@synthesize attributes = _attributes;

- (BOOL) representsIvar {
    return _attributes.ivar.length > 0;
}

- (BOOL) representsObject {
    return NO;
}

- (BOOL) representsModelObject {
    return NO;
}

- (BOOL) representsArray {
    return NO;
}

- (id<FLStringEncoder>) objectEncoder {
    return nil;
}

- (id) createRepresentedObject {
    return nil; 
}

+ (id) propertyDescriber {
    return FLAutorelease([[[self class] alloc] init]);
}

+ (id) propertyDescriber:(Class) objectClass {
    FLPropertyDescriber* property = nil;

    if([objectClass isModelObject]) {
        property = [FLModelObjectPropertyDescriber propertyDescriber];
    }
    else {
        property = [objectClass propertyDescriber];
    }

    property.representedObjectDescriber = [objectClass objectDescriber];

    return property;
}

+ (id) propertyDescriberWithProperty_t:(objc_property_t) property_t {

    FLPropertyAttributes_t attributes = FLPropertyAttributesParse(property_t);

    NSString* propertyName = FLAutorelease([[NSString alloc] initWithCString:attributes.propertyName encoding:NSASCIIStringEncoding]);
    FLAssertStringIsNotEmpty(propertyName);
    
    FLPropertyDescriber* property = nil;

    if(attributes.is_object) {

        Class objectClass = nil;
        
        if(attributes.className.string) {
            objectClass = NSClassFromString([NSString stringWithCharString:attributes.className]);
        }
        else {
            objectClass = [FLAbstractObjectType class];
        }

        FLAssertNotNilWithComment(objectClass, @"Can't find class for: \"%@\"", [NSString stringWithCharString:attributes.className] );

        property = [FLPropertyDescriber propertyDescriber:objectClass];
    }
    else {
        if(attributes.is_bool_number) {
            property = [FLBoolNumberPropertyDescriber propertyDescriber];
        }
        else if(attributes.is_number) {
            property = [FLNumberPropertyDescriber propertyDescriber];
        }
    }
    
    FLAssertNotNilWithComment(property, @"propertyDescriber not created for %@", propertyName);

    property.propertyName = propertyName;
    property.attributes = attributes;

    return property;
}

+ (id) propertyDescriber:(NSString*) name propertyClass:(Class) aClass {
    FLPropertyDescriber* describer = [FLPropertyDescriber propertyDescriber:aClass];
    describer.propertyName = name;
    return describer;
}

+ (id) propertyDescriber:(NSString*) name class:(Class) aClass {
    return [FLPropertyDescriber propertyDescriber:name propertyClass:aClass];
}

- (Class) representedObjectClass {
    return _representedObjectDescriber.objectClass;
}   

- (FLPropertyDescriber*) containedTypeForName:(NSString*) name {
    @synchronized(self) {
        for(FLPropertyDescriber* property in _containedTypes) {
            if(FLStringsAreEqual(property.propertyName, name)) {
                return property;
            }
        }
    }
    return nil;
}

- (NSUInteger) containedTypesCount {
    @synchronized(self) {
        return _containedTypes.count;
    }
}

- (FLPropertyDescriber*) containedTypeForIndex:(NSUInteger) idx {
    @synchronized(self) {
        return [_containedTypes objectAtIndex:idx];
    }
}
- (FLPropertyDescriber*) containedTypeForClass:(Class) aClass {
    @synchronized(self) {
        for(FLPropertyDescriber* subType in _containedTypes) {
            if([aClass isKindOfClass:[subType representedObjectClass]]) {
                return subType;
            }
        }
    }
    return nil;
}

- (BOOL) representsClass:(Class) aClass {
    return self.representedObjectClass == aClass;
}

- (void) setContainedTypes:(NSArray*) types {
    @synchronized(self) {
        FLSetObjectWithCopy(_containedTypes, types);
    }
}

- (NSArray*) containedTypes {
    @synchronized(self) {
        return FLCopyWithAutorelease(_containedTypes);
    }
}

- (void) addContainedProperty:(NSString*) name withClass:(Class) aClass {

    if(!_containedTypes) {
        _containedTypes = [[NSMutableArray alloc] init];
    }

    [_containedTypes addObject:[FLPropertyDescriber propertyDescriber:name class:aClass]];
}

- (NSString*) description {
    
    FLPrettyString* contained = nil;
    
    for(FLPropertyDescriber* describer in _containedTypes) {
        if(!contained) {
            contained = [FLPrettyString prettyString];
            [contained indent];
        }
    
        [contained appendBlankLine];
        [contained appendFormat:@"%@", [describer description]];
    }
    
    return [NSString stringWithFormat:@"%@ %@: %@ %@", [super description], self.propertyName, NSStringFromClass(self.representedObjectClass), contained ? [contained string] : @""];
}

#if FL_MRC
- (void) dealloc {
    [_representedObjectDescriber release];
	[_propertyName release];
    [_containedTypes release];
    [super dealloc];
}
#endif

- (FLDatabaseType) databaseColumnType {

    if(_attributes.is_object) {
        return [self.representedObjectClass databaseColumnType];
    }
    else if (_attributes.is_number) {
        return _attributes.is_float_number ? FLDatabaseTypeFloat : FLDatabaseTypeInteger;
    }
    else {
        return FLDatabaseTypeObject; // it'll be boxes, like in a NSValue.
    }


}
@end


@implementation FLObjectPropertyDescriber : FLPropertyDescriber

- (BOOL) representsObject {
    return YES;
}

- (id<FLStringEncoder>) objectEncoder {
    return [[self representedObjectClass] objectEncoder];
}

- (id) createRepresentedObject {
    return FLAutorelease([[[self representedObjectClass] alloc] init]);
}

@end

@implementation FLModelObjectPropertyDescriber : FLObjectPropertyDescriber

- (BOOL) representsModelObject {
    return YES;
}

- (id<FLStringEncoder>) objectEncoder {
    return nil;
}

@end

@implementation FLArrayPropertyDescriber : FLObjectPropertyDescriber

- (BOOL) representsModelObject {
    return NO;
}

- (BOOL) representsArray {
    return YES;
}

- (id<FLStringEncoder>) objectEncoder {
    return nil;
}

- (id) createRepresentedObject {
    return [NSMutableArray array];
}

@end

@implementation FLValuePropertyDescriber 

- (BOOL) representsObject {
    return NO;
}

- (BOOL) representsModelObject {
    return NO;
}

- (BOOL) representsArray {
    return NO;
}

- (id) createRepresentedObject {
    return nil;
}

@end

@implementation FLNumberPropertyDescriber 

- (BOOL) representsObject {
    return NO;
}

- (id<FLStringEncoder>) objectEncoder {
    return self;
}

- (NSString*) encodeObjectToString:(id) object withEncoder:(id) encoder {
    return [encoder encodeStringWithNumber:object];
}

- (id) decodeStringToObject:(NSString*) string withDecoder:(id) decoder {
    return [decoder decodeNumberFromString:string];
}

//- (FLDatabaseIgnored) representedObjectSqlType {
//    return self.attributes.is_float_number ? FLDatabaseIgnored : FLDatabaseIgnored;
//}

- (id) representedObjectFromSqliteColumnData:(NSData*) data {
    return nil;
}

- (id) representedObjectFromSqliteColumnString:(NSString*) string {
    return nil;
}
@end

@implementation FLBoolNumberPropertyDescriber 

//- (FLDatabaseIgnored) representedObjectSqlType {
//    return FLDatabaseIgnored;
//}

- (NSString*) encodeObjectToString:(id) object withEncoder:(id) encoder {
    return [encoder encodeStringWithBOOL:object];
}

- (id) decodeStringToObject:(NSString*) string withDecoder:(id) decoder {
    return [decoder decodeBOOLFromString:string];
}
@end

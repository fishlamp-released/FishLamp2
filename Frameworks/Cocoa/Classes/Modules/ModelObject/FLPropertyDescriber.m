//
//  FLPropertyDescriber.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/22/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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

#define LazySelectorGetter(name, ivar, char_string) \
- (SEL) name { \
    if(!ivar) { \
        @synchronized(self) { \
            if(!ivar) { \
                ivar = NSSelectorFromString([NSString stringWithCharString:_attributes.customSetter]); \
            } \
        } \
    } \
    return ivar; \
}

@interface FLPropertyDescriber ()

@property (readwrite, strong) NSString* propertyKey;
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
@synthesize propertyKey = _propertyKey;
@synthesize serializationKey = _serializationKey;

FLSynthesizeLazyGetterWithBlock(structName, NSString*, _structName, ^{
    return [NSString stringWithCharString:_attributes.structName]; }
    );

FLSynthesizeLazyGetterWithBlock(unionName, NSString*, _unionName, ^{
    return [NSString stringWithCharString:_attributes.unionName];
});

FLSynthesizeLazyGetterWithBlock(ivarName, NSString*, _ivarName, ^{
    return [NSString stringWithCharString:_attributes.ivar]; }
);

//FLSynthesizeLazyGetterWithBlock(customGetter, SEL, _customGetter, ^{ \
//    return NSSelectorFromString([NSString stringWithCharString:_attributes.customGetter]); \
//})'
//
//FLSynthesizeLazyGetterWithBlock(customSetter, SEL, _customSetter, ^{ \
//    return NSSelectorFromString([NSString stringWithCharString:_attributes.customSetter]); \
//});
//
//FLSynthesizeLazyGetterWithBlock(selector, SEL, _customSetter, ^{ \
//    return NSSelectorFromString([NSString stringWithCharString:_attributes.customSetter]); \
//});

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

- (void) setPropertyNameAndKeys:(NSString*) name {
    FLSetObjectWithRetain(_propertyName, name);
    self.serializationKey = name;
    self.propertyKey = [name lowercaseString];
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

    [property setPropertyNameAndKeys:propertyName];
    property.attributes = attributes;

    return property;
}

+ (id) propertyDescriber:(NSString*) name propertyClass:(Class) aClass {
    FLPropertyDescriber* property = [FLPropertyDescriber propertyDescriber:aClass];
    [property setPropertyNameAndKeys:name];
    return property;
}

+ (id) propertyDescriber:(NSString*) name class:(Class) aClass {
    return [FLPropertyDescriber propertyDescriber:name propertyClass:aClass];
}

- (Class) representedObjectClass {
    return _representedObjectDescriber.objectClass;
}   

- (FLPropertyDescriber*) containedTypeForName:(NSString*) name {
// TODO: figure out a better way to make this thread safe
    @synchronized(self) {
        name = [name lowercaseString];
        for(FLPropertyDescriber* property in _containedTypes) {
            if(FLStringsAreEqual(property.propertyKey, name)) {
                return property;
            }
        }
    }
    return nil;
}

- (NSUInteger) containedTypesCount {
// TODO: figure out a better way to make this thread safe
    @synchronized(self) {
        return _containedTypes.count;
    }
}

- (FLPropertyDescriber*) containedTypeForIndex:(NSUInteger) idx {
// TODO: figure out a better way to make this thread safe
    @synchronized(self) {
        return [_containedTypes objectAtIndex:idx];
    }
}
- (FLPropertyDescriber*) containedTypeForClass:(Class) aClass {
 // TODO: figure out a better way to make this thread safe
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
// TODO: figure out a better way to make this thread safe
    @synchronized(self) {
        FLSetObjectWithCopy(_containedTypes, types);
    }
}

// TODO: figure out a better way to make this thread safe
- (NSArray*) containedTypes {
    @synchronized(self) {
        return FLCopyWithAutorelease(_containedTypes);
    }
}

- (void) addContainedProperty:(NSString*) name withClass:(Class) aClass {

    [self addContainedProperty:[FLPropertyDescriber propertyDescriber:name class:aClass]];
}

- (void) addContainedProperty:(FLPropertyDescriber*) propertyDescriber {
    if(!_containedTypes) {
        _containedTypes = [[NSMutableArray alloc] init];
    }

    [_containedTypes addObject:propertyDescriber];
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
    [_structName release];
    [_ivarName release];
    [_unionName release];
    [_serializationKey release];
    [_propertyKey release];
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

- (NSString*) stringEncodingKeyForRepresentedData {
    return nil;
}
@end


@implementation FLObjectPropertyDescriber : FLPropertyDescriber

- (BOOL) representsObject {
    return YES;
}

//- (id<FLStringEncoder>) objectEncoder {
//    return [[self representedObjectClass] objectEncoder];
//}

- (id) createRepresentedObject {
    return FLAutorelease([[[self representedObjectClass] alloc] init]);
}

- (NSString*) stringEncodingKeyForRepresentedData {
    return [[self representedObjectClass] stringEncodingKey];
}

@end

@implementation FLModelObjectPropertyDescriber : FLObjectPropertyDescriber

- (BOOL) representsModelObject {
    return YES;
}

@end

@implementation FLArrayPropertyDescriber : FLObjectPropertyDescriber

- (BOOL) representsModelObject {
    return NO;
}

- (BOOL) representsArray {
    return YES;
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

- (NSString*) stringEncodingKeyForRepresentedData {
    return nil;
}

@end

@implementation FLNumberPropertyDescriber 

- (NSString*) stringEncodingKeyForRepresentedData {
    return [NSNumber stringEncodingKey];
}

@end

@implementation FLBoolNumberPropertyDescriber 


- (NSString*) stringEncodingKeyForRepresentedData {
    return [FLBoolStringEncoder stringEncodingKey];
}

@end

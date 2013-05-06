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
#import "FLSqlStatement.h"

@interface FLValuePropertyDescriber : FLPropertyDescriber
@end

@interface FLNumberPropertyDescriber : FLValuePropertyDescriber<FLStringEncoder>
@end

@interface FLObjectPropertyDescriber : FLPropertyDescriber
@end

@interface FLModelObjectPropertyDescriber : FLObjectPropertyDescriber
@end

@interface FLArrayPropertyDescriber : FLObjectPropertyDescriber
@end

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
@property (readwrite) NSString* propertyName;
@property (readwrite) FLObjectDescriber* representedObjectDescriber;
@property (readwrite, copy) NSArray* containedTypes;
@property (readonly, assign) Class propertyClass;
@property (readwrite, assign) FLPropertyAttributes_t attributes;

//+ (id) propertyDescriber:(NSString*) identifier 
//representedObjectDescriber:(FLObjectDescriber*) representedObjectDescriber;
//
////+ (id) propertyDescriber:(NSString*) identifier 
////           propertyClass:(Class) aClass;
//
//+ (id) propertyDescriber:(NSString*) identifier 
//           propertyClass:(Class) aClass 
//          containedTypes:(NSArray*) containedTypes;

+ (id) propertyDescriberWithProperty_t:(objc_property_t) property_t;

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

//- (id) initWithProperty_t:(objc_property_t) property_t {
//
//    self = [super init];
//    if(self) {
//       
//        
////        if(attributes.propertyName) {
////
////            if(attributes.is_object) {
////                FLTrace(@"adding object property \"%s\" (%s)", attributes.propertyName, attributes.encodedAttributes);
////
////                NSString* propertyName = [NSString stringWithCString:attributes.propertyName encoding:NSASCIIStringEncoding];
////                Class objectClass = nil;
////                
////                if(attributes.className.string) {
////                    objectClass = NSClassFromString([NSString stringWithCharString:attributes.className]);
////                }
////                else {
////                    objectClass = [FLAbstractObjectType class];
////                }
////
////                return [FLPropertyDescriber propertyDescriber:propertyName propertyClass:objectClass];
////            }
////            else {
////                FLTrace(@"skipping property: %s (%s)", attributes.propertyName, attributes.encodedAttributes);
////            }
////        }
//    }
//    
//    return self;
//}

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

    NSString* propertyName = [[NSString alloc] initWithCString:attributes.propertyName encoding:NSASCIIStringEncoding];
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
        if(attributes.is_number) {
            property = [FLNumberPropertyDescriber propertyDescriber];
        }
    }
    
    FLAssertNotNilWithComment(property, @"propertyDescriber not created for %@", propertyName);

    property.propertyName = propertyName;
    property.attributes = attributes;

    return property;
}

- (FLDatabaseType) representedObjectSqlType {
    return [[self propertyClass] sqlType];
}

- (id) representedObjectFromSqliteColumnData:(NSData*) data {
    return [[self propertyClass] decodeObjectWithSqliteColumnData:data];
}

- (id) representedObjectFromSqliteColumnString:(NSString*) string {
    return [[self propertyClass] decodeObjectWithSqliteColumnString:string];
}

//- (id) initWithPropertyName:(NSString*) propertyName 
// representedObjectDescriber:(FLObjectDescriber*) representedObjectDescriber
//             containedTypes:(NSArray*) containedTypes {	
//
//    FLAssertNotNil(propertyName);
//    FLAssertNotNil(representedObjectDescriber);
//	self = [super init];
//	if(self) {
//        self.representedObjectDescriber = representedObjectDescriber;
//        self.propertyName = propertyName;
//        _containedTypes = [containedTypes copy];
//	}
//	return self;
//}

+ (id) propertyDescriber:(NSString*) name propertyClass:(Class) aClass {
    FLPropertyDescriber* describer = [FLPropertyDescriber propertyDescriber:aClass];
    describer.propertyName = name;
    return describer;
}

+ (id) propertyDescriber:(NSString*) name class:(Class) aClass {
    return [FLPropertyDescriber propertyDescriber:name propertyClass:aClass];
}

//+ (id) propertyDescriber:(NSString*) name 
//representedObjectDescriber:(FLObjectDescriber*) representedObjectDescriber {
//    return FLAutorelease([[[self class] alloc] initWithPropertyName:name representedObjectDescriber:representedObjectDescriber containedTypes:nil]);
//}            

//+ (id) propertyDescriber:(NSString*) name 
//           propertyClass:(Class) aClass 
//          containedTypes:(NSArray*) containedTypes {
//
//    FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:aClass];
//    if(describer) {
//        return FLAutorelease([[FLPropertyDescriber alloc] initWithPropertyName:name 
//                                                                  representedObjectDescriber:describer 
//                                                                containedTypes:containedTypes]);
//    }
//    
//    return nil;
//}

//- (id) copyWithZone:(NSZone *)zone {
////    return [[FLPropertyDescriber alloc] initWithPropertyName:_propertyName 
////                                                representedObjectDescriber:_representedObjectDescriber 
////                                              containedTypes:FLCopyWithAutorelease(_containedTypes)];
//}

- (Class) propertyClass {
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
            if([aClass isKindOfClass:[subType propertyClass]]) {
                return subType;
            }
        }
    }
    return nil;
}

- (BOOL) representsClass:(Class) aClass {
    return self.propertyClass == aClass;
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

//- (void) describeTo:(FLPrettyString*) string {
//    [string appendLineWithFormat:@"propertyName %@, representedObjectDescriber %@", self.propertyName, [self.representedObjectDescriber description]];
//}

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
    
    return [NSString stringWithFormat:@"%@ %@: %@ %@", [super description], self.propertyName, NSStringFromClass(self.propertyClass), contained ? [contained string] : @""];
}

#if FL_MRC
- (void) dealloc {
    [_representedObjectDescriber release];
	[_propertyName release];
    [_containedTypes release];
    [super dealloc];
}
#endif
@end


@implementation FLObjectPropertyDescriber : FLPropertyDescriber

- (id<FLStringEncoder>) objectEncoder {
    return [[self propertyClass] objectEncoder];
}

- (id) createRepresentedObject {
    return FLAutorelease([[[self propertyClass] alloc] init]);
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

- (id<FLStringEncoder>) objectEncoder {
    return self;
}

- (NSString*) encodeObjectToString:(id) object withEncoder:(id) encoder {
    return [encoder encodeStringWithNumber:object];
}

- (id) decodeStringToObject:(NSString*) string withDecoder:(id) decoder {
    return [decoder decodeNumberFromString:string];
}

@end
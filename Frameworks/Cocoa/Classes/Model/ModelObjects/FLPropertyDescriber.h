//
//  FLPropertyDescriber.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/22/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLPropertyAttributes.h"
#import "FLStringEncoder.h"
#import "FLDatabase.h"

@class FLObjectDescriber;

@interface FLPropertyDescriber : NSObject {
@private
    NSString* _propertyName;
    FLObjectDescriber* _representedObjectDescriber;
    NSMutableArray* _containedTypes;
    
    FLPropertyAttributes_t _attributes;
    NSString* _structName;
    NSString* _ivarName;
    NSString* _unionName;
    SEL _customGetter;
    SEL _customSetter;
    SEL _selector;
}

// property attributes
@property (readonly, strong) NSString* propertyName;
@property (readonly, strong, nonatomic) NSString* structName;
@property (readonly, strong, nonatomic) NSString* ivarName;
@property (readonly, strong, nonatomic) NSString* unionName;
@property (readonly, assign, nonatomic) SEL customGetter;
@property (readonly, assign, nonatomic) SEL customSetter;
@property (readonly, assign, nonatomic) SEL selector;
@property (readonly, assign, nonatomic) BOOL representsIvar;

// represented object 
@property (readonly, assign) Class representedObjectClass;
@property (readonly, assign) BOOL representsObject;
@property (readonly, assign) BOOL representsModelObject;
@property (readonly, assign) BOOL representsArray;
- (BOOL) representsClass:(Class) aClass;
- (id) createRepresentedObject;

// contained types
@property (readonly, strong) NSArray* containedTypes;
@property (readonly, assign) NSUInteger containedTypesCount;
- (FLPropertyDescriber*) containedTypeForIndex:(NSUInteger) idx;
- (FLPropertyDescriber*) containedTypeForClass:(Class) aClass;
- (FLPropertyDescriber*) containedTypeForName:(NSString*) name;

+ (id) propertyDescriber:(NSString*) identifier 
           propertyClass:(Class) aClass;


- (NSString*) stringEncodingKeyForRepresentedData;

@property (readonly, assign) FLDatabaseType databaseColumnType;          
@end

@interface FLPropertyDescriber (Deprecated)
+ (id) propertyDescriber:(NSString*) name class:(Class) aClass;
@end

@interface FLValuePropertyDescriber : FLPropertyDescriber
@end

@interface FLNumberPropertyDescriber : FLValuePropertyDescriber 
@end

@interface FLBoolNumberPropertyDescriber : FLValuePropertyDescriber
@end


@interface FLObjectPropertyDescriber : FLPropertyDescriber
@end

@interface FLModelObjectPropertyDescriber : FLObjectPropertyDescriber
@end

@interface FLArrayPropertyDescriber : FLObjectPropertyDescriber
@end
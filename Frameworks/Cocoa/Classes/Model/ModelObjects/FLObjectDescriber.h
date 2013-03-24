//
//  FLObjectDescriber.h
//  PackMule
//
//  Created by Mike Fullerton on 6/30/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FishLampCore.h"
#import "FLObjectDescriber.h"
#import "FLPropertyAttributes.h"
#import "FLObjectEncoder.h"
#import "FLCoreTypes.h"

@interface FLObjectDescriber : NSObject {
@private 
    NSString* _objectName;
    Class _objectClass;
	NSMutableDictionary* _properties;
    
    FLObjectEncoder* _objectEncoder;
    FLPropertyAttributes_t _attributes;
}
@property (readonly, strong, nonatomic) NSString* objectName;
@property (readonly, assign, nonatomic) Class objectClass;
@property (readwrite, strong, nonatomic) FLObjectEncoder* objectEncoder;
@property (readonly, copy, nonatomic) NSDictionary* properties;
@property (readonly, assign, nonatomic) BOOL hasProperties;

- (id) initWithClass:(Class) aClass;
+ (id) objectDescriber:(Class) aClass;
+ (id) objectDescriber:(NSString*) name objectClass:(Class) aClass;

- (id) initWithRuntimeProperty:(objc_property_t) runtimeProperty;
+ (id) objectDescriberWithRuntimeProperty:(objc_property_t) property;

- (FLObjectDescriber*) propertyForName:(NSString*) propertyName;

//- (void) addProperty:(FLObjectDescriber*) property;
- (void) addProperty:(NSString*) name withClass:(Class) objectClass;
//- (void) addProperty:(NSString*) name withArrayType:(FLObjectDescriber*) namedType;
- (void) addProperty:(NSString*) name withArrayTypes:(NSArray*) types;

@end

@interface NSObject (FLObjectDescriber)
+ (FLObjectDescriber*) objectDescriber;
- (FLObjectDescriber*) objectDescriber;
@end

typedef enum {
	FLMergeModePreserveDestination,		//! always keep dest value, even if src has value.
	FLMergeModeSourceWins,				//! if src has value, overwrite dest value.
} FLMergeMode;


// this only works for objects with valid describers.
extern void FLMergeObjects(id dest, id src, FLMergeMode mergeMode);
extern void FLMergeObjectArrays(NSMutableArray* dest, NSArray* src, FLMergeMode mergeMode, NSArray* arrayItemTypes);


@interface FLSelfDescribingObject : NSObject
@end
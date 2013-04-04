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
	NSMutableDictionary* _childDescribers;
    
    FLObjectEncoder* _objectEncoder;
    FLPropertyAttributes_t _attributes;
}

@property (readonly, strong, nonatomic) NSString* objectName;
@property (readonly, assign, nonatomic) Class objectClass;
@property (readonly, copy, nonatomic) NSDictionary* childDescribers;
@property (readonly, assign, nonatomic) FLPropertyAttributes_t propertyAttributes;

@property (readwrite, strong, nonatomic) FLObjectEncoder* objectEncoder;

- (id) initWithClass:(Class) aClass;

- (id) initWithClass:(Class) aClass 
      withObjectName:(NSString*) name;

+ (id) objectDescriberForClass:(Class) aClass
                withObjectName:(NSString*) name;

+ (id) objectDescriberForClass:(Class) aClass;

- (FLObjectDescriber*) childDescriberForObjectName:(NSString*) propertyName;

- (void) addChildDescriberWithName:(NSString*) name withClass:(Class) objectClass;
- (void) addChildDescriberWithName:(NSString*) name withArrayTypes:(NSArray*) types;

// deprecated
+ (id) objectDescriber:(NSString*) name objectClass:(Class) aClass;

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
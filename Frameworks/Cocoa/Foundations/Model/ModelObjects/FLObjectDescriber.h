//
//  FLObjectDescriber.h
//  PackMule
//
//  Created by Mike Fullerton on 6/30/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FishLampCore.h"
#import "FLPropertyType.h"

@interface FLObjectDescriber : NSObject {
@private 
    Class _describingClass;
	NSMutableDictionary* _properties;
}
@property (readonly, copy, nonatomic) NSDictionary* properties;
@property (readonly, assign, nonatomic) Class describingClass;

- (id) initWithClass:(Class) aClass;

+ (id) objectDescriber:(Class) aClass;

- (FLPropertyType*) propertyForName:(NSString*) propertyName;

- (void) addProperty:(FLPropertyType*) property;

- (void) addProperty:(NSString*) name withClass:(Class) propertyClass;

- (void) addProperty:(NSString*) name withArrayType:(FLPropertyType*) namedType;

- (void) addProperty:(NSString*) name withArrayTypes:(NSArray*) types;

@end

typedef void (^FLObjectDescriberPropertyVisitor)(id object, FLPropertyType* propertyType, BOOL* stop);

@interface NSObject (FLObjectDescriber)

+ (FLObjectDescriber*) objectDescriber;

@property (readonly, assign, nonatomic) FLObjectDescriber* objectDescriber;

- (void) visitDescribedObjectAndProperties:(FLObjectDescriberPropertyVisitor) visitor;

- (void) performSelectorOnDescribedObjectAndProperties:(SEL) sel;
- (void) performSelectorOnDescribedObjectAndProperties:(SEL) sel withObject:(id) object;
- (void) performSelectorOnDescribedObjectAndProperties:(SEL) sel withObject:(id) object1 withObject:(id) object2;
- (void) performSelectorOnDescribedObjectAndProperties:(SEL) sel withObject:(id) object1 withObject:(id) object2 withObject:(id) object3;


// ovverride this in your collections or whatever
- (void) visitSelf:(FLObjectDescriberPropertyVisitor) visitor
              stop:(BOOL*) stop;

@end

typedef enum {
	FLMergeModePreserveDestination,		//! always keep dest value, even if src has value.
	FLMergeModeSourceWins,				//! if src has value, overwrite dest value.
} FLMergeMode;


// this only works for objects with valid describers.
extern void FLMergeObjects(id dest, id src, FLMergeMode mergeMode);
extern void FLMergeObjectArrays(NSMutableArray* dest, NSArray* src, FLMergeMode mergeMode, NSArray* arrayItemTypes);


@interface FLDescribeableObject : NSObject {
@private
}
@end
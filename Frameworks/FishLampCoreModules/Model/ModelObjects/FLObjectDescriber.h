//
//  FLObjectDescriber.h
//  PackMule
//
//  Created by Mike Fullerton on 6/30/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"

#import "FLPropertyDescription.h"

typedef void (^FLObjectDescriberPropertyVisitor)(FLPropertyDescription* property);

@interface FLObjectDescriber : NSObject<NSCopying> {
@private 
	NSMutableDictionary* _properties;
}

- (id) init;
- (id) initWithPropertyDescribers:(NSDictionary*) dictionary;

@property (readonly, copy, nonatomic) NSDictionary* propertyDescribers;

- (void) setPropertyDescriber:(FLPropertyDescription*) objectDescriber forPropertyName:(NSString*) propertyName;
- (FLPropertyDescription*) propertyDescriberForPropertyName:(NSString*) propertyName;


// this fills in all the properties for the class, including superclasses (Not including NSObject) using Objective-c runtime info.
- (void) addPropertiesForClass:(Class) aClass;

- (void) visitAllProperties:(FLObjectDescriberPropertyVisitor) visitor;

@end

@interface NSObject (FLObjectDescriber)

+ (FLObjectDescriber*) sharedObjectDescriber;

@property (readonly, assign, nonatomic) FLObjectDescriber* objectDescriber;

@end

typedef enum {
	FLMergeModePreserveDestination,		//! always keep dest value, even if src has value.
	FLMergeModeSourceWins,				//! if src has value, overwrite dest value.
} FLMergeMode;


// this only works for objects with valid describers.
extern void FLMergeObjects(id dest, id src, FLMergeMode mergeMode);
extern void FLMergeObjectArrays(NSMutableArray* dest, NSArray* src, FLMergeMode mergeMode, NSArray* arrayItemTypes);

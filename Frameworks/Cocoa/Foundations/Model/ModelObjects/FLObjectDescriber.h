//
//  FLObjectDescriber.h
//  PackMule
//
//  Created by Mike Fullerton on 6/30/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FishLampCore.h"

#import "FLPropertyDescription.h"


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

//- (void) visitAllProperties:(FLObjectDescriberPropertyVisitor) visitor;

@end

typedef void (^FLObjectDescriberPropertyVisitor)(FLPropertyDescription* propertyDescription, id propertyObject, id parentObject, BOOL* stop);

@interface NSObject (FLObjectDescriber)

+ (FLObjectDescriber*) sharedObjectDescriber;

@property (readonly, assign, nonatomic) FLObjectDescriber* objectDescriber;

- (void) visitDescribedPropertiesRecursive:(BOOL) recursive
                                   visitor:(FLObjectDescriberPropertyVisitor) visitor;



@end

typedef enum {
	FLMergeModePreserveDestination,		//! always keep dest value, even if src has value.
	FLMergeModeSourceWins,				//! if src has value, overwrite dest value.
} FLMergeMode;


// this only works for objects with valid describers.
extern void FLMergeObjects(id dest, id src, FLMergeMode mergeMode);
extern void FLMergeObjectArrays(NSMutableArray* dest, NSArray* src, FLMergeMode mergeMode, NSArray* arrayItemTypes);

//
//  FLObjectDescriber.h
//  PackMule
//
//  Created by Mike Fullerton on 6/30/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLTypeDesc.h"
#import "FLObjcRuntime.h"
#import "FLPropertyAttributes.h"

@interface FLObjectDescriber : FLTypeDesc 

+ (id) objectDescriber:(Class) aClass;

// deprecated
- (void) setChildForIdentifier:(NSString*) name withClass:(Class) objectClass;
- (void) setChildForIdentifier:(NSString*) name withArrayTypes:(NSArray*) types;

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
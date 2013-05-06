//
//  FLPropertyAttributes.h
//  FishLampCore
//
//  Created by Mike Fullerton on 3/18/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLCharString.h"

#ifndef FLPropertyAttributesBufferSize
#define FLPropertyAttributesBufferSize 256
#endif

typedef struct {
    char encodedAttributes[FLPropertyAttributesBufferSize];
    char propertyName[FLPropertyAttributesBufferSize];

    // these are pointers into the various strings
    FLCharString className;
    FLCharString structName;
    FLCharString customGetter;
    FLCharString customSetter;
    FLCharString ivar;
    FLCharString selector;
    FLCharString unionName;
    
    unsigned int is_object: 1;
    unsigned int is_array: 1;
    unsigned int is_union: 1;
    unsigned int is_number: 1;
    unsigned int is_float_number: 1;
    unsigned int retain:1;
    unsigned int readonly: 1;
    unsigned int copy: 1;
    unsigned int weak: 1;
    unsigned int nonatomic: 1;
    unsigned int dynamic: 1;
    unsigned int eligible_for_gc : 1;
    unsigned int indirect_count:8;
    unsigned int is_pointer:1;
    char type; // see runtime.h
} FLPropertyAttributes_t;

extern FLPropertyAttributes_t FLPropertyAttributesParse(objc_property_t property);

//extern void FLPropertyAttributesFree(FLPropertyAttributes_t* attributes);
//
//extern void FLPropertyAttributesDecodeWithNoCopy(objc_property_t property, FLPropertyAttributes_t* attributes);

//@interface FLPropertyAttributes : NSObject {
//@private
//
//    SEL _customGetter;
//    SEL _customSetter;
//    SEL _selector;
//    
//// types
//    NSString* _className;
//    NSString* _structName;
//    NSString* _ivarName;
//    NSString* _unionName;
//    
//    FLPropertyAttributes_t _attributes;
//}
//- (id) initWithParsedAttributes:(FLPropertyAttributes_t) parsed;
//+ (id) propertyAttributes:(FLPropertyAttributes_t) parsed;
//
//
//@end

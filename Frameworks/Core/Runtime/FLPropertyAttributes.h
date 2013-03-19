//
//  FLPropertyAttributes.h
//  FishLampCore
//
//  Created by Mike Fullerton on 3/18/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLCharString.h"
#import "NSString+FLCharString.h"

typedef struct {
    objc_property_t property;

    const char* encodedAttributes;
    const char* propertyName;
    
    FLCharString className;
    FLCharString structName;
    FLCharString customGetter;
    FLCharString customSetter;
    FLCharString ivar;
    FLCharString selectorName;
    FLCharString unionName;

    unsigned int is_object: 1;
    unsigned int is_array: 1;
    unsigned int is_union: 1;
    unsigned int retain:1;
    unsigned int readonly: 1;
    unsigned int copy: 1;
    unsigned int weak: 1;
    unsigned int nonatomic: 1;
    unsigned int dynamic: 1;
    unsigned int eligible_for_gc : 1;
    unsigned int indirect_count:8;

    unsigned int needs_free: 1;
    
} FLPropertyAttributes_t;

extern void FLPropertyAttributesDecodeWithCopy(objc_property_t property, FLPropertyAttributes_t* attributes);
extern void FLPropertyAttributesFree(FLPropertyAttributes_t* attributes);

extern void FLPropertyAttributesDecodeWithNoCopy(objc_property_t property, FLPropertyAttributes_t* attributes);


// [Generated]
//
// This file was generated at 7/10/12 5:03 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCodeArrayType.h
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLModelObject.h"
#import "FLCodeVariable.h"
@class FLCodeProperty;

// FLCodeArrayType
@interface FLCodeArrayType : FLCodeVariable { 
@private
    FLCodeProperty* __wildcardProperty;
}

/// @brief: Getter will create __wildcardProperty if nil. Alternately, use the wildcardPropertyObject property, which will not lazy create it.
@property (readwrite, strong, nonatomic) FLCodeProperty* wildcardProperty;

+ (FLCodeArrayType*) arrayType; 

/// @brief: This returns __wildcardProperty. It does NOT create it if it's NIL.
@property (readonly, strong, nonatomic) FLCodeProperty* wildcardPropertyObject;

- (void) createWildcardPropertyIfNil; 
@end

// [/Generated]

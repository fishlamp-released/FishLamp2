// [Generated]
//
// This file was generated at 7/10/12 5:03 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCodeEnumType.h
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLModelObject.h"
#import "FLCodeType.h"
@class FLCodeEnum;

// FLCodeEnumType
@interface FLCodeEnumType : FLCodeType<NSCopying> { 
@private
    NSMutableArray* __enums;
}

/// @brief: Getter will create __enums if nil. Alternately, use the enumsObject property, which will not lazy create it.
@property (readwrite, strong, nonatomic) NSMutableArray* enums;
/// Type: FLCodeEnum*, forKey: enum

+ (FLCodeEnumType*) enumType; 

/// @brief: This returns __enums. It does NOT create it if it's NIL.
@property (readonly, strong, nonatomic) NSMutableArray* enumsObject;
/// Type: FLCodeEnum*, forKey: enum

- (void) createEnumsIfNil; 
@end

// [/Generated]

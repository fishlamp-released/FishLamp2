// [Generated]
//
// This file was generated at 7/10/12 5:03 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCodeArray.h
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLModelObject.h"


@class FLCodeArrayType;

// FLCodeArray
@interface FLCodeArray : FLModelObject { 
@private
    NSString* __name;
    NSMutableArray* __types;
}

@property (readwrite, strong, nonatomic) NSString* name;

/// @brief: Getter will create __types if nil. Alternately, use the typesObject property, which will not lazy create it.
@property (readwrite, strong, nonatomic) NSMutableArray* types;
/// Type: FLCodeArrayType*, forKey: arrayType

+ (FLCodeArray*) array; 

/// @brief: This returns __types. It does NOT create it if it's NIL.
@property (readonly, strong, nonatomic) NSMutableArray* typesObject;
/// Type: FLCodeArrayType*, forKey: arrayType

- (void) createTypesIfNil; 
@end

// [/Generated]

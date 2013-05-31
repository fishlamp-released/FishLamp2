// [Generated]
//
// This file was generated at 7/10/12 5:03 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCodeType.h
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLModelObject.h"


// FLCodeType
/**
represents a type an name
*/

@interface FLCodeType : FLModelObject { 
@private
    NSString* __typeName;
    NSString* __defaultValue;
    NSString* __typeNameUnmodified;
}

@property (readwrite, strong, nonatomic) NSString* defaultValue;

/// @brief: name of the type, e.g. MyObject
@property (readwrite, strong, nonatomic) NSString* typeName;

@property (readwrite, strong, nonatomic) NSString* typeNameUnmodified;

+ (FLCodeType*) type; 

@end


// [/Generated]

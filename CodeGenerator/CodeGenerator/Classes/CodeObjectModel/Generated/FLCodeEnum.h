// [Generated]
//
// This file was generated at 7/10/12 5:03 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCodeEnum.h
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLModelObject.h"


// FLCodeEnum
@interface FLCodeEnum : FLModelObject { 
@private
    NSString* __name;
    int __value;
    NSString* __stringValue;
}

/// @brief: This is the name of the enum, e.g. kFoo
@property (readwrite, strong, nonatomic) NSString* name;

/// @brief: This is the string optional value of the define
@property (readwrite, strong, nonatomic) NSString* stringValue;

/// @brief: This is the optional value of the enum, e.g. 5
@property (readwrite, assign, nonatomic) int value;

+ (FLCodeEnum*) enum; 

@end

// [/Generated]

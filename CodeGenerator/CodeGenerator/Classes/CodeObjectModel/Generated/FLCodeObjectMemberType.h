// [Generated]
//
// This file was generated at 7/10/12 5:03 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCodeObjectMemberType.h
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLModelObject.h"
#import "FLCodeVariable.h"

// FLCodeObjectMemberType
@interface FLCodeObjectMemberType : FLCodeVariable<NSCopying> { 
@private
    BOOL __isStatic;
    BOOL __isWeak;
}

+ (FLCodeObjectMemberType*) objectMemberType; 


@property (readwrite, assign, nonatomic) BOOL isStatic;

/// @brief: NO by default
@property (readwrite, assign, nonatomic) BOOL isWeak;
@end


// [/Generated]

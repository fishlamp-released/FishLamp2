// [Generated]
//
// This file was generated at 7/10/12 5:03 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCodeVariable.h
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLModelObject.h"
#import "FLCodeType.h"

// FLCodeVariable
@interface FLCodeVariable : FLCodeType<NSCopying> { 
@private
    NSString* __name;
}

/// @brief: name of the type, e.g. bagelCount
@property (readwrite, strong, nonatomic) NSString* name;

+ (FLCodeVariable*) variable; 

@end

// [/Generated]

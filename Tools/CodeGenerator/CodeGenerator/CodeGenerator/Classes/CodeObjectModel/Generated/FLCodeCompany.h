// [Generated]
//
// This file was generated at 7/10/12 5:03 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCodeCompany.h
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLModelObject.h"


// FLCodeCompany
@interface FLCodeCompany : FLModelObject { 
@private
    NSString* __name;
    NSString* __website;
    NSString* __address1;
    NSString* __address2;
    NSString* __address3;
    NSString* __phone;
}

/// @brief: company address1
@property (readwrite, strong, nonatomic) NSString* address1;

/// @brief: company address1
@property (readwrite, strong, nonatomic) NSString* address2;

/// @brief: company address1
@property (readwrite, strong, nonatomic) NSString* address3;

/// @brief: name of the company for the file headers
@property (readwrite, strong, nonatomic) NSString* name;

/// @brief: company phone
@property (readwrite, strong, nonatomic) NSString* phone;

/// @brief: name of the company for the file headers
@property (readwrite, strong, nonatomic) NSString* website;

+ (FLCodeCompany*) company; 

@end


// [/Generated]

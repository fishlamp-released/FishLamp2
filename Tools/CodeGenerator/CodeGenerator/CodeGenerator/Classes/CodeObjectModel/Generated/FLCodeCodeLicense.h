// [Generated]
//
// This file was generated at 7/10/12 5:03 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCodeCodeLicense.h
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLModelObject.h"


// FLCodeCodeLicense
@interface FLCodeCodeLicense : FLModelObject { 
@private
    NSString* __licenseName;
    NSString* __licenseShortDescription;
    NSString* __licenseTextFilePath;
}

@property (readwrite, strong, nonatomic) NSString* licenseName;

/// @brief: license short description
@property (readwrite, strong, nonatomic) NSString* licenseShortDescription;

@property (readwrite, strong, nonatomic) NSString* licenseTextFilePath;

+ (FLCodeCodeLicense*) codeLicense; 

@end


// [/Generated]

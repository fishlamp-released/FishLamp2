// [Generated]
//
// This file was generated at 7/10/12 5:10 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCodeImport.h
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLModelObject.h"
#import "FLCodeEnums.h"


// FLCodeImport
@interface FLCodeImport : FLModelObject { 
@private
    NSString* __path;
    NSString* __type;
}

/// @brief: import a whittle file
@property (readwrite, strong, nonatomic) NSString* path;

/// @brief: import wsdl url (file or HTTP)
@property (readwrite, strong, nonatomic) NSString* type;

+ (FLCodeImport*) import; 


/// @brief: This sets/gets single enum (stored as string) as value. It uses [FLCodeCodeGeneratorEnumLookup instance] to lookup enum
@property (readwrite, assign, nonatomic) FLCodeInputType typeAsEnum;

/// @brief: This sets/gets enum mask (stored/parsed as comma delimited string) as a NSSet. It uses [FLCodeCodeGeneratorEnumLookup instance] to lookup enums.
@property (readwrite, strong, nonatomic) NSSet* typeValues;
@end



// [/Generated]

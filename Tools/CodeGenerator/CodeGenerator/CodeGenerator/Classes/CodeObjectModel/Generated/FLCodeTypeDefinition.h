// [Generated]
//
// This file was generated at 7/10/12 5:03 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCodeTypeDefinition.h
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLModelObject.h"
#import "FLCodeEnums.h"


// FLCodeTypeDefinition
@interface FLCodeTypeDefinition : FLModelObject { 
@private
    NSString* __dataType;
    NSString* __typeName;
    NSString* __import;
    BOOL __importIsPrivate;
    NSString* __typeNameUnmodified;
}

/// @brief: the dataType of the type, e.g. object, struct, int, array
@property (readwrite, strong, nonatomic) NSString* dataType;
@property (readwrite, assign, nonatomic) FLCodeTypeID dataTypeAsEnum;
@property (readwrite, strong, nonatomic) NSSet* dataTypeValues;

@property (readwrite, strong, nonatomic) NSString* import;

@property (readwrite, assign, nonatomic) BOOL importIsPrivate;

/// @brief: name of the type, e.g. MyObject
@property (readwrite, strong, nonatomic) NSString* typeName;

@property (readwrite, strong, nonatomic) NSString* typeNameUnmodified;

+ (FLCodeTypeDefinition*) typeDefinition; 

@end


// [/Generated]

// [Generated]
//
// This file was generated at 7/9/12 1:47 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// FLCodeEnums.h
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLModelObject.h"
#import "FLEnumHandler.h"

#define kFLCodeDataTypeObject @"Object"
#define kFLCodeDataTypeValue @"Value"
#define kFLCodeDataTypeEnum @"Enum"
#define kFLCodeDataTypeImmuteable @"Immuteable"
#define kFLCodeInputTypeHttp @"Http"
#define kFLCodeInputTypeFile @"File"
#define kFLCodeInputTypeWsdl @"Wsdl"

typedef enum {
    FLCodeDataTypeObject,
    FLCodeDataTypeValue,
    FLCodeTypeEnum,
    FLCodeDataTypeImmuteable,
} FLCodeTypeID;

typedef enum {
    FLCodeInputTypeHttp,
    FLCodeInputTypeFile,
    FLCodeInputTypeWsdl,
} FLCodeInputType;

@interface FLCodeCodeGeneratorEnumLookup : FLEnumHandler {
}
FLSingletonProperty(FLCodeCodeGeneratorEnumLookup);

- (NSString*) stringFromDataType:(FLCodeTypeID) inEnum;
- (FLCodeTypeID) dataTypeFromString:(NSString*) inString;

- (NSString*) stringFromInputType:(FLCodeInputType) inEnum;
- (FLCodeInputType) inputTypeFromString:(NSString*) inString;
@end
// [/Generated]

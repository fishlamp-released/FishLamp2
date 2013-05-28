// [Generated]
//
// This file was generated at 7/10/12 5:03 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCodeGeneratorOptions.h
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLModelObject.h"


@class FLCodeDefine;

// FLCodeGeneratorOptions
@interface FLCodeGeneratorOptions : FLModelObject { 
@private
    BOOL __disabled;
    NSString* __typePrefix;
    NSString* __comment;
    FLCodeDefine* __globalDefine;
    BOOL __generateAllIncludesFile;
    NSString* __objectsFolderName;
    BOOL __useGeneratedFolder;
}

/// @brief: don't compile this object is set to YES
@property (readwrite, assign, nonatomic) BOOL disabled;

/// @brief: set this to YES to create an includes file that includes all the generated headers
@property (readwrite, assign, nonatomic) BOOL generateAllIncludesFile;

/// @brief: if this is YES then generated files (prefixed with __) will be written into their own subfolder nameed __schemaName.
@property (readwrite, assign, nonatomic) BOOL useGeneratedFolder;


@property (readwrite, strong, nonatomic) NSString* comment;


/// @brief: Getter will create __globalDefine if nil. Alternately, use the globalDefineObject property, which will not lazy create it.
@property (readwrite, strong, nonatomic) FLCodeDefine* globalDefine;
/// @brief: This returns __globalDefine. It does NOT create it if it's NIL.
@property (readonly, strong, nonatomic) FLCodeDefine* globalDefineObject;

- (void) createGlobalDefineIfNil; 

/// @brief: folder to generated the files to. By default this is the same as the xml schema file
@property (readwrite, strong, nonatomic) NSString* objectsFolderName;

@property (readwrite, strong, nonatomic) NSString* typePrefix;

+ (FLCodeGeneratorOptions*) generatorOptions; 

@end


// [/Generated]

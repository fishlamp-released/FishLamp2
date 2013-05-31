// [Generated]
//
// This file was generated at 7/10/12 5:03 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCodeMethod.h
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLModelObject.h"
#import "FLCodeLine.h"

@class FLCodeCodeSnippet;
@class FLCodeVariable;

// FLCodeMethod
@interface FLCodeMethod : FLModelObject { 
@private
    BOOL __isStatic;
    BOOL __isPrivate;
    NSString* __returnType;
    NSString* __name;
    NSString* __comment;
    FLCodeCodeSnippet* __code;
    NSMutableArray* __parameters;
    
    NSMutableArray* _codeLines;
}

/// @brief: Getter will create __code if nil. Alternately, use the codeObject property, which will not lazy create it.
//@property (readwrite, strong, nonatomic) FLCodeCodeSnippet* code;

/// @brief: comment about this method
@property (readwrite, strong, nonatomic) NSString* comment;

/// @brief: is this a class method, e.g. + (void) foo
@property (readwrite, assign, nonatomic) BOOL isStatic;

/// @brief: don't show the header in the header for this method
@property (readwrite, assign, nonatomic) BOOL isPrivate;

/// @brief: name of the method
@property (readwrite, strong, nonatomic) NSString* name;

/// @brief: Getter will create __parameters if nil. Alternately, use the parametersObject property, which will not lazy create it.
@property (readwrite, strong, nonatomic) NSMutableArray* parameters;
/// Type: FLCodeVariable*, forKey: parameter

/// @brief: return type of the method, by default this is void
@property (readwrite, strong, nonatomic) NSString* returnType;

+ (FLCodeMethod*) method; 

/// @brief: This returns __code. It does NOT create it if it's NIL.
@property (readonly, strong, nonatomic) FLCodeCodeSnippet* codeObject;

/// @brief: This returns __parameters. It does NOT create it if it's NIL.
@property (readonly, strong, nonatomic) NSMutableArray* parametersObject;
/// Type: FLCodeVariable*, forKey: parameter

- (void) createCodeIfNil; 

- (void) createParametersIfNil; 

@property (readwrite, strong, nonatomic) NSMutableArray* codeLines;


@end

// [/Generated]

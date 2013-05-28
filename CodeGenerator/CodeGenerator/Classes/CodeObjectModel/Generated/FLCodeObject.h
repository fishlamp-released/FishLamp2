// [Generated]
//
// This file was generated at 7/10/12 5:03 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCodeObject.h
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLModelObject.h"
#import "FLCodeType.h"
@class FLCodeStorageOptions;
@class FLCodeObjectCategory;
@class FLCodeTypeDefinition;
@class FLCodeVariable;
@class FLCodeMethod;
@class FLCodeProperty;
@class FLCodeCodeSnippet;

// FLCodeObject
@interface FLCodeObject : FLCodeType<NSCopying> { 
@private
    NSString* __protocols;
    NSString* __className;
    FLCodeStorageOptions* __storageOptions;
    NSString* __comment;
    NSString* __superclass;
    BOOL __disabled;
    BOOL __canLazyCreate;
    BOOL __isWildcardArray;
    NSString* __ifDef;
    BOOL __isSingleton;
    NSMutableArray* __properties;
    NSMutableArray* __dependencies;
    NSMutableArray* __members;
    NSMutableArray* __methods;
    NSMutableArray* __sourceSnippets;
    NSMutableArray* __linesForInitMethod;
    NSMutableArray* __deallocLines;
    NSMutableArray* __categories;
}


/// @brief: Getter will create __categories if nil. Alternately, use the categoriesObject property, which will not lazy create it.
@property (readwrite, strong, nonatomic) NSMutableArray* categories;
/// Type: FLCodeObjectCategory*, forKey: category

/// @brief: comment for this object
@property (readwrite, strong, nonatomic) NSString* comment;

/// @brief: Getter will create __deallocLines if nil. Alternately, use the deallocLinesObject property, which will not lazy create it.
@property (readwrite, strong, nonatomic) NSMutableArray* deallocLines;
/// Type: NSString*, forKey: deallocLine

/// @brief: Getter will create __dependencies if nil. Alternately, use the dependenciesObject property, which will not lazy create it.
@property (readwrite, strong, nonatomic) NSMutableArray* dependencies;
/// Type: FLCodeTypeDefinition*, forKey: dependency


@property (readwrite, strong, nonatomic) NSString* ifDef;

/// @brief: Getter will create __linesForInitMethod if nil. Alternately, use the linesForInitMethodObject property, which will not lazy create it.
@property (readwrite, strong, nonatomic) NSMutableArray* linesForInitMethod;
/// Type: NSString*, forKey: line



/// @brief: Getter will create __members if nil. Alternately, use the membersObject property, which will not lazy create it.
@property (readwrite, strong, nonatomic) NSMutableArray* members;
/// Type: FLCodeVariable*, forKey: member

/// @brief: Getter will create __methods if nil. Alternately, use the methodsObject property, which will not lazy create it.
@property (readwrite, strong, nonatomic) NSMutableArray* methods;
/// Type: FLCodeMethod*, forKey: method

/// @brief: name of the type, e.g. bagelCount
@property (readwrite, strong, nonatomic) NSString* className;

/// @brief: Getter will create __properties if nil. Alternately, use the propertiesObject property, which will not lazy create it.
@property (readwrite, strong, nonatomic) NSMutableArray* properties;
/// Type: FLCodeProperty*, forKey: property

/// @brief: comma delimeted string
@property (readwrite, strong, nonatomic) NSString* protocols;

/// @brief: Getter will create __sourceSnippets if nil. Alternately, use the sourceSnippetsObject property, which will not lazy create it.
@property (readwrite, strong, nonatomic) NSMutableArray* sourceSnippets;
/// Type: FLCodeCodeSnippet*, forKey: code

/// @brief: Getter will create __storageOptions if nil. Alternately, use the storageOptionsObject property, which will not lazy create it.
@property (readwrite, strong, nonatomic) FLCodeStorageOptions* storageOptions;

/// @brief: superclass for the object. by default this is set to NSObject
@property (readwrite, strong, nonatomic) NSString* superclass;

+ (FLCodeObject*) object; 

/// @brief: don't compile this object is set to YES
@property (readwrite, assign, nonatomic) BOOL disabled;

@property (readwrite, assign, nonatomic) BOOL canLazyCreate;

@property (readwrite, assign, nonatomic) BOOL isWildcardArray;

/// @brief: if set to YES the standard FishLamp singleton objects will be generated for this object
@property (readwrite, assign, nonatomic) BOOL isSingleton;

/// @brief: This returns __storageOptions. It does NOT create it if it's NIL.
@property (readonly, strong, nonatomic) FLCodeStorageOptions* storageOptionsObject;

/// @brief: This returns __properties. It does NOT create it if it's NIL.
@property (readonly, strong, nonatomic) NSMutableArray* propertiesObject;
/// Type: FLCodeProperty*, forKey: property

/// @brief: This returns __dependencies. It does NOT create it if it's NIL.
@property (readonly, strong, nonatomic) NSMutableArray* dependenciesObject;
/// Type: FLCodeTypeDefinition*, forKey: dependency

/// @brief: This returns __members. It does NOT create it if it's NIL.
@property (readonly, strong, nonatomic) NSMutableArray* membersObject;
/// Type: FLCodeVariable*, forKey: member

/// @brief: This returns __methods. It does NOT create it if it's NIL.
@property (readonly, strong, nonatomic) NSMutableArray* methodsObject;
/// Type: FLCodeMethod*, forKey: method

/// @brief: This returns __sourceSnippets. It does NOT create it if it's NIL.
@property (readonly, strong, nonatomic) NSMutableArray* sourceSnippetsObject;
/// Type: FLCodeCodeSnippet*, forKey: code

/// @brief: This returns __linesForInitMethod. It does NOT create it if it's NIL.
@property (readonly, strong, nonatomic) NSMutableArray* linesForInitMethodObject;
/// Type: NSString*, forKey: line

/// @brief: This returns __deallocLines. It does NOT create it if it's NIL.
@property (readonly, strong, nonatomic) NSMutableArray* deallocLinesObject;
/// Type: NSString*, forKey: deallocLine

/// @brief: This returns __categories. It does NOT create it if it's NIL.
@property (readonly, strong, nonatomic) NSMutableArray* categoriesObject;
/// Type: FLCodeObjectCategory*, forKey: category

- (void) createStorageOptionsIfNil; 

- (void) createPropertiesIfNil; 

- (void) createDependenciesIfNil; 

- (void) createMembersIfNil; 

- (void) createMethodsIfNil; 

- (void) createSourceSnippetsIfNil; 

- (void) createInitLinesIfNil; 

- (void) createDeallocLinesIfNil; 

- (void) createCategoriesIfNil; 
@end

// [/Generated]

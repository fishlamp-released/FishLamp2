// [Generated]
//
// This file was generated at 7/10/12 5:03 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCodeProperty.h
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLModelObject.h"

@class FLCodeStorageOptions;
@class FLCodeMethod;
@class FLCodeEnumType;
@class FLCodeArrayType;
#import "FLCodeLine.h"

// FLCodeProperty
@interface FLCodeProperty : FLModelObject { 
@private
    NSString* __name;
    NSString* __type;
    FLCodeStorageOptions* __storageOptions;
    NSString* __memberName;
    FLCodeLine* __defaultValue;
    NSString* __comment;
    FLCodeMethod* __getter;
    FLCodeMethod* __setter;
    NSMutableArray* __arrayTypes;
    BOOL __canLazyCreate;
    BOOL __isPrivate;
    BOOL __isReadOnly;
    BOOL __isImmutable;
    BOOL __isStatic;
    BOOL __useForEquality;
    BOOL __isWildcardArray;
    BOOL __isWeak;
    NSString* __typeUnmodified;
    NSString* __nameUnmodified;
    FLCodeEnumType* __enumType;
    BOOL __hasCustomCode;
}

/// @brief: Getter will create __arrayTypes if nil. Alternately, use the arrayTypesObject property, which will not lazy create it.
@property (readwrite, strong, nonatomic) NSMutableArray* arrayTypes;
/// Type: FLCodeArrayType*, forKey: arrayType


/// @brief: comment about this property
@property (readwrite, strong, nonatomic) NSString* comment;

@property (readwrite, strong, nonatomic) FLCodeLine* defaultValue;

/// @brief: Getter will create __enumType if nil. Alternately, use the enumTypeObject property, which will not lazy create it.
@property (readwrite, strong, nonatomic) FLCodeEnumType* enumType;

/// @brief: Getter will create __getter if nil. Alternately, use the getterObject property, which will not lazy create it.
@property (readwrite, strong, nonatomic) FLCodeMethod* getter;/// @brief: set member name. this is the same as the property name by default, but can be anything
@property (readwrite, strong, nonatomic) NSString* memberName;

@property (readwrite, strong, nonatomic) NSString* name;

/// @brief: internal use only
@property (readwrite, strong, nonatomic) NSString* nameUnmodified;

/// @brief: Getter will create __setter if nil. Alternately, use the setterObject property, which will not lazy create it.
@property (readwrite, strong, nonatomic) FLCodeMethod* setter;

/// @brief: Getter will create __storageOptions if nil. Alternately, use the storageOptionsObject property, which will not lazy create it.
@property (readwrite, strong, nonatomic) FLCodeStorageOptions* storageOptions;

@property (readwrite, strong, nonatomic) NSString* type;

/// @brief: internal use only
@property (readwrite, strong, nonatomic) NSString* typeUnmodified;

/// @brief: automatically create the data (if it's an object) when the property getter is called and the value is nil
@property (readwrite, assign, nonatomic) BOOL canLazyCreate;

/// @brief: don't declare the property in the file header (good for overriding superclass methods)
@property (readwrite, assign, nonatomic) BOOL isPrivate;

/// @brief: make this property readonly
@property (readwrite, assign, nonatomic) BOOL isReadOnly;

/// @brief: immutable means readonly, and directly return the default value without storing it in a member variable
@property (readwrite, assign, nonatomic) BOOL isImmutable;

/// @brief: is this property a class method e.g. + (void) foo
@property (readwrite, assign, nonatomic) BOOL isStatic;

@property (readwrite, assign, nonatomic) BOOL useForEquality;

@property (readwrite, assign, nonatomic) BOOL isWildcardArray;

/// @brief: NO by default
@property (readwrite, assign, nonatomic) BOOL isWeak;

/// @brief: Properties by default have member data associated with them, set this to YES to disable this.
@property (readwrite, assign, nonatomic) BOOL hasCustomCode;

+ (FLCodeProperty*) property; 

/// @brief: This returns __storageOptions. It does NOT create it if it's NIL.
@property (readonly, strong, nonatomic) FLCodeStorageOptions* storageOptionsObject;

/// @brief: This returns __getter. It does NOT create it if it's NIL.
@property (readonly, strong, nonatomic) FLCodeMethod* getterObject;

/// @brief: This returns __setter. It does NOT create it if it's NIL.
@property (readonly, strong, nonatomic) FLCodeMethod* setterObject;

/// @brief: This returns __arrayTypes. It does NOT create it if it's NIL.
@property (readonly, strong, nonatomic) NSMutableArray* arrayTypesObject;
/// Type: FLCodeArrayType*, forKey: arrayType

/// @brief: This returns __enumType. It does NOT create it if it's NIL.
@property (readonly, strong, nonatomic) FLCodeEnumType* enumTypeObject;

- (void) createStorageOptionsIfNil; 

- (void) createGetterIfNil; 

- (void) createSetterIfNil; 

- (void) createArrayTypesIfNil; 

- (void) createEnumTypeIfNil; 
@end

// [/Generated]

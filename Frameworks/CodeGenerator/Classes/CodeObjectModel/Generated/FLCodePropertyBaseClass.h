// 
// FLCodePropertyBaseClass.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/16/13 3:03 PM with PackMule (3.0.0.29)
// 
// Project: FishLamp Code Generator
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "FLModelObject.h"
#import "FLCodeStorageMask.h"

@class FLCodeStorageOptions;
@class FLObjectDescriber;
@class FLCodeArrayType;
@class FLCodeMethod;

@interface FLCodePropertyBaseClass : FLModelObject {
@private
    id _defaultValue;
    NSString* _memberName;
    BOOL _isStatic;
    BOOL _isPrivate;
    NSMutableArray* _arrayTypes;
    BOOL _useForEquality;
    BOOL _isWildcardArray;
    FLCodeStorageOptions* _storageOptions;
    NSString* _type;
    NSString* _comment;
    BOOL _isWeak;
    FLCodeMethod* _setter;
    FLCodeMethod* _getter;
    BOOL _isImmutable;
    NSString* _storage;
    BOOL _isReadOnly;
    NSString* _name;
    BOOL _canLazyCreate;
}

@property (readwrite, strong, nonatomic) NSMutableArray* arrayTypes;
@property (readwrite, assign, nonatomic) BOOL canLazyCreate;
@property (readwrite, strong, nonatomic) NSString* comment;
@property (readwrite, strong, nonatomic) id defaultValue;
@property (readwrite, strong, nonatomic) FLCodeMethod* getter;
@property (readwrite, assign, nonatomic) BOOL isImmutable;
@property (readwrite, assign, nonatomic) BOOL isPrivate;
@property (readwrite, assign, nonatomic) BOOL isReadOnly;
@property (readwrite, assign, nonatomic) BOOL isStatic;
@property (readwrite, assign, nonatomic) BOOL isWeak;
@property (readwrite, assign, nonatomic) BOOL isWildcardArray;
@property (readwrite, strong, nonatomic) NSString* memberName;
@property (readwrite, strong, nonatomic) NSString* name;
@property (readwrite, strong, nonatomic) FLCodeMethod* setter;
@property (readwrite, strong, nonatomic) NSString* storage;
@property (readwrite, assign, nonatomic) FLCodeStorageMask storageEnum;
@property (readwrite, strong, nonatomic) FLCodeStorageMaskEnumSet* storageEnumSet;
@property (readwrite, strong, nonatomic) FLCodeStorageOptions* storageOptions;
@property (readwrite, strong, nonatomic) NSString* type;
@property (readwrite, assign, nonatomic) BOOL useForEquality;

@end
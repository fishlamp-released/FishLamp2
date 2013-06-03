// 
// FLCodeObject.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/3/13 10:33 AM with PackMule (3.0.0.1)
// 
// Project: FishLamp Code Generator
// Schema: ObjectModel
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "FLCodeType.h"

@class FLCodeStorageOptions;
@class FLCodeTypeDefinition;
@class FLCodeMethod;
@class FLCodeVariable;
@class FLObjectDescriber;
@class FLCodeCodeSnippet;
@class FLCodeProperty;
@class FLCodeObjectCategory;

@interface FLCodeObject : FLCodeType<NSCopying> {
@private
    NSMutableArray* _methods;
    BOOL _isWildcardArray;
    NSString* _protocols;
    NSMutableArray* _categories;
    NSMutableArray* _members;
    NSString* _superclass;
    BOOL _disabled;
    FLCodeStorageOptions* _storageOptions;
    NSString* _comment;
    NSMutableArray* _sourceSnippets;
    NSMutableArray* _linesForInitMethod;
    NSString* _className;
    NSString* _ifDef;
    NSMutableArray* _properties;
    NSMutableArray* _dependencies;
    BOOL _isSingleton;
    NSMutableArray* _deallocLines;
    BOOL _canLazyCreate;
}

@property (readwrite, assign, nonatomic) BOOL canLazyCreate;
@property (readwrite, strong, nonatomic) NSMutableArray* categories;
@property (readwrite, strong, nonatomic) NSString* className;
@property (readwrite, strong, nonatomic) NSString* comment;
@property (readwrite, strong, nonatomic) NSMutableArray* deallocLines;
@property (readwrite, strong, nonatomic) NSMutableArray* dependencies;
@property (readwrite, assign, nonatomic) BOOL disabled;
@property (readwrite, strong, nonatomic) NSString* ifDef;
@property (readwrite, assign, nonatomic) BOOL isSingleton;
@property (readwrite, assign, nonatomic) BOOL isWildcardArray;
@property (readwrite, strong, nonatomic) NSMutableArray* linesForInitMethod;
@property (readwrite, strong, nonatomic) NSMutableArray* members;
@property (readwrite, strong, nonatomic) NSMutableArray* methods;
@property (readwrite, strong, nonatomic) NSMutableArray* properties;
@property (readwrite, strong, nonatomic) NSString* protocols;
@property (readwrite, strong, nonatomic) NSMutableArray* sourceSnippets;
@property (readwrite, strong, nonatomic) FLCodeStorageOptions* storageOptions;
@property (readwrite, strong, nonatomic) NSString* superclass;

+ (FLCodeObject*) codeObject;

@end

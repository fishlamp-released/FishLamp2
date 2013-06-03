// 
// FLCodeMethod.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/2/13 5:40 PM with PackMule (3.0.0.100)
// 
// Project: FishLamp Code Generator
// Schema: ObjectModel
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "FLModelObject.h"

@class FLCodeVariable;
@class FLObjectDescriber;
@class FLCodeCodeSnippet;

@interface FLCodeMethod : FLModelObject<NSCopying> {
@private
    NSString* _returnType;
    BOOL _isStatic;
    NSMutableArray* _parameters;
    BOOL _isPrivate;
    FLCodeCodeSnippet* _code;
    NSString* _comment;
    NSMutableArray* _codeLines;
    NSString* _name;
}

@property (readwrite, strong, nonatomic) FLCodeCodeSnippet* code;
@property (readwrite, strong, nonatomic) NSMutableArray* codeLines;
@property (readwrite, strong, nonatomic) NSString* comment;
@property (readwrite, assign, nonatomic) BOOL isPrivate;
@property (readwrite, assign, nonatomic) BOOL isStatic;
@property (readwrite, strong, nonatomic) NSString* name;
@property (readwrite, strong, nonatomic) NSMutableArray* parameters;
@property (readwrite, strong, nonatomic) NSString* returnType;

+ (FLCodeMethod*) codeMethod;

@end

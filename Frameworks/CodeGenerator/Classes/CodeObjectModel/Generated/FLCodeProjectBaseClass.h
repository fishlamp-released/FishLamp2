// 
// FLCodeProjectBaseClass.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/15/13 4:24 PM with PackMule (3.0.0.29)
// 
// Project: FishLamp Code Generator
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "FLModelObject.h"

@class FLCodeGeneratorOptions;
@class FLCodeTypeDefinition;
@class FLCodeObject;
@class FLCodeProjectInfo;
@class FLCodeImport;
@class FLCodeEnumType;
@class FLCodeDefine;
@class FLCodeArray;
@class FLObjectDescriber;

@interface FLCodeProjectBaseClass : FLModelObject {
@private
    FLCodeGeneratorOptions* _options;
    NSMutableArray* _objects;
    NSMutableArray* _dependencies;
    NSMutableArray* _arrays;
    NSMutableArray* _imports;
    NSMutableArray* _enumTypes;
    NSMutableArray* _typeDefinitions;
    NSString* _comment;
    NSMutableArray* _defines;
    FLCodeProjectInfo* _info;
}

@property (readwrite, strong, nonatomic) NSMutableArray* arrays;
@property (readwrite, strong, nonatomic) NSString* comment;
@property (readwrite, strong, nonatomic) NSMutableArray* defines;
@property (readwrite, strong, nonatomic) NSMutableArray* dependencies;
@property (readwrite, strong, nonatomic) NSMutableArray* enumTypes;
@property (readwrite, strong, nonatomic) NSMutableArray* imports;
@property (readwrite, strong, nonatomic) FLCodeProjectInfo* info;
@property (readwrite, strong, nonatomic) NSMutableArray* objects;
@property (readwrite, strong, nonatomic) FLCodeGeneratorOptions* options;
@property (readwrite, strong, nonatomic) NSMutableArray* typeDefinitions;

@end
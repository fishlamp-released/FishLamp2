// 
// FLCodeTypeDefinitionBaseClass.h
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
#import "FLDataType.h"

@class FLDataTypeEnumSet;

@interface FLCodeTypeDefinitionBaseClass : FLModelObject {
@private
    NSString* _typeName;
    NSString* _import;
    BOOL _importIsPrivate;
    NSString* _dataType;
    NSString* _typeNameUnmodified;
}

@property (readwrite, strong, nonatomic) NSString* dataType;
@property (readwrite, assign, nonatomic) FLDataType dataTypeEnum;
@property (readwrite, strong, nonatomic) FLDataTypeEnumSet* dataTypeEnumSet;
@property (readwrite, strong, nonatomic) NSString* import;
@property (readwrite, assign, nonatomic) BOOL importIsPrivate;
@property (readwrite, strong, nonatomic) NSString* typeName;
@property (readwrite, strong, nonatomic) NSString* typeNameUnmodified;

@end

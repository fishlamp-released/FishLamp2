// 
// FLCodeEnumTypeBaseClass.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/16/13 5:30 PM with PackMule (3.0.0.29)
// 
// Project: FishLamp Code Generator
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "FLModelObject.h"

@class FLCodeEnum;
@class FLObjectDescriber;

@interface FLCodeEnumTypeBaseClass : FLModelObject {
@private
    NSString* _name;
    NSMutableArray* _enums;
}

@property (readwrite, strong, nonatomic) NSMutableArray* enums;
@property (readwrite, strong, nonatomic) NSString* name;

@end

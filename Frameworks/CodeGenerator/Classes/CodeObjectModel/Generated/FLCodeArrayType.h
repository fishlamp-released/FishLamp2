// 
// FLCodeArrayType.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/14/13 2:45 PM with PackMule (3.0.0.29)
// 
// Project: ObjectModel
// Schema: ObjectModel
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "FLCodeVariable.h"

@class FLCodeProperty;

@interface FLCodeArrayType : FLCodeVariable<NSCopying> {
@private
    FLCodeProperty* _wildcardProperty;
}

@property (readwrite, strong, nonatomic) FLCodeProperty* wildcardProperty;

+ (FLCodeArrayType*) codeArrayType;

@end

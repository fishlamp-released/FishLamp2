// 
// FLCodeArrayTypeBaseClass.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/15/13 4:24 PM with PackMule (3.0.0.29)
// 
// Project: FishLamp Code Generator
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "FLCodeVariable.h"

@class FLCodeProperty;

@interface FLCodeArrayTypeBaseClass : FLCodeVariable {
@private
    FLCodeProperty* _wildcardProperty;
}

@property (readwrite, strong, nonatomic) FLCodeProperty* wildcardProperty;

@end
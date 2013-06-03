// 
// FLCodeDefine.h
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

#import "FLModelObject.h"


@interface FLCodeDefine : FLModelObject<NSCopying> {
@private
    BOOL _isString;
    NSString* _value;
    NSString* _comment;
    NSString* _define;
}

@property (readwrite, strong, nonatomic) NSString* comment;
@property (readwrite, strong, nonatomic) NSString* define;
@property (readwrite, assign, nonatomic) BOOL isString;
@property (readwrite, strong, nonatomic) NSString* value;

+ (FLCodeDefine*) codeDefine;

@end

// 
// FLCodeEnum.h
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


@interface FLCodeEnum : FLModelObject<NSCopying> {
@private
    NSString* _name;
    int _value;
    NSString* _stringValue;
}

@property (readwrite, strong, nonatomic) NSString* name;
@property (readwrite, strong, nonatomic) NSString* stringValue;
@property (readwrite, assign, nonatomic) int value;

+ (FLCodeEnum*) codeEnum;

@end

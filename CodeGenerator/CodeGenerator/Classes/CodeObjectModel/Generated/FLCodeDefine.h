// [Generated]
//
// This file was generated at 7/9/12 2:05 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCodeDefine.h
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLModelObject.h"


// FLCodeDefine
@interface FLCodeDefine : FLModelObject { 
@private
    NSString* __define;
    NSString* __value;
    BOOL __isString;
    NSString* __comment;
}

@property (readwrite, strong, nonatomic) NSString* comment;

@property (readwrite, strong, nonatomic) NSString* define;

@property (readwrite, assign, nonatomic) BOOL isString;

@property (readwrite, strong, nonatomic) NSString* value;

+ (FLCodeDefine*) define; 

@end


// [/Generated]

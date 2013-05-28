// [Generated]
//
// This file was generated at 7/9/12 2:05 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCodeKeyValuePair.h
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLModelObject.h"


// FLCodeKeyValuePair
@interface FLCodeKeyValuePair : FLModelObject { 
@private
    NSString* __key;
    NSString* __value;
}

@property (readwrite, strong, nonatomic) NSString* key;

@property (readwrite, strong, nonatomic) NSString* value;

+ (FLCodeKeyValuePair*) keyValuePair; 

@end


// [/Generated]

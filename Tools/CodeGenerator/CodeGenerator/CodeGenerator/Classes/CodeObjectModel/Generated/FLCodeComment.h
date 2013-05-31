// [Generated]
//
// This file was generated at 7/9/12 2:05 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCodeComment.h
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLModelObject.h"


// FLCodeComment
/**
don't use this object directly, used internally
*/

@interface FLCodeComment : FLModelObject { 
@private
    NSString* __object;
    NSString* __commentID;
    NSString* __comment;
}

@property (readwrite, strong, nonatomic) NSString* comment;

@property (readwrite, strong, nonatomic) NSString* commentID;

@property (readwrite, strong, nonatomic) NSString* object;

+ (FLCodeComment*) comment; 

@end

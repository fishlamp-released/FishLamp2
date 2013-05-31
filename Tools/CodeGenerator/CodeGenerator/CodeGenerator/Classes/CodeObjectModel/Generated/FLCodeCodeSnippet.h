// [Generated]
//
// This file was generated at 7/10/12 5:03 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCodeCodeSnippet.h
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLModelObject.h"


// FLCodeCodeSnippet
/**
represents a block of code
*/

@interface FLCodeCodeSnippet : FLModelObject { 
@private
    NSString* __scopedBy;
    NSString* __name;
    NSString* __comment;
    NSString* __lines;
}

/// @brief: a comment about this snippet
@property (readwrite, strong, nonatomic) NSString* comment;

@property (readwrite, strong, nonatomic) NSString* lines;

/// @brief: name of snippet (used for file)
@property (readwrite, strong, nonatomic) NSString* name;

@property (readwrite, strong, nonatomic) NSString* scopedBy;


+ (FLCodeCodeSnippet*) codeSnippet; 

@end

// [/Generated]

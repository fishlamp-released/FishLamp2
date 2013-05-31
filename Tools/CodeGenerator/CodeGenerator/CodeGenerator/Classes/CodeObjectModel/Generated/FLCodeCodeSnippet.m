// [Generated]
//
// This file was generated at 7/9/12 1:47 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCodeCodeSnippet.m
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCodeCodeSnippet.h"

@implementation FLCodeCodeSnippet


@synthesize comment = __comment;
@synthesize lines = __lines;
@synthesize name = __name;
@synthesize scopedBy = __scopedBy;

+ (FLCodeCodeSnippet*) codeSnippet
{
    return FLAutorelease([[FLCodeCodeSnippet alloc] init]);
}

- (void) dealloc
{
    FLRelease(__scopedBy);
    FLRelease(__name);
    FLRelease(__comment);
    FLRelease(__lines);
    FLSuperDealloc();
}

@end

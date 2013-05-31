// [Generated]
//
// This file was generated at 7/9/12 1:47 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCodeDefine.m
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCodeDefine.h"

@implementation FLCodeDefine

@synthesize comment = __comment;
@synthesize define = __define;
@synthesize isString = __isString;
@synthesize value = __value;


- (void) dealloc
{
    FLRelease(__define);
    FLRelease(__value);
    FLRelease(__comment);
    FLSuperDealloc();
}

+ (FLCodeDefine*) define
{
    return FLAutorelease([[FLCodeDefine alloc] init]);
}

- (NSUInteger) hash
{
    return [[self comment] hash];
}

- (BOOL) isEqual:(id) object
{
    return [object isKindOfClass:[self class]] && [[object comment] isEqual:[self comment]];
}

@end

// [/Generated]

// [Generated]
//
// This file was generated at 7/9/12 1:47 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCodeKeyValuePair.m
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCodeKeyValuePair.h"

@implementation FLCodeKeyValuePair

@synthesize key = __key;
@synthesize value = __value;

- (void) dealloc
{
    FLRelease(__key);
    FLRelease(__value);
    FLSuperDealloc();
}

- (NSUInteger) hash
{
    return [[self key] hash];
}

- (BOOL) isEqual:(id) object
{
    return [object isKindOfClass:[self class]] && [[object key] isEqual:[self key]];
}

+ (FLCodeKeyValuePair*) keyValuePair
{
    return FLAutorelease([[FLCodeKeyValuePair alloc] init]);
}

@end

// [/Generated]

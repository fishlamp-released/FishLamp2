// [Generated]
//
// This file was generated at 7/10/12 5:10 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCodeImport.m
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCodeImport.h"
#import "FLCodeEnums.h"

@implementation FLCodeImport


@synthesize path = __path;
@synthesize type = __type;



- (void) dealloc
{
    FLRelease(__path);
    FLRelease(__type);
    FLSuperDealloc();
}

+ (FLCodeImport*) import
{
    return FLAutorelease([[FLCodeImport alloc] init]);
}


// This sets/gets single enum (stored as string) as value. It uses [FLCodeCodeGeneratorEnumLookup instance] to lookup enum
- (FLCodeInputType) typeAsEnum
{
    return [[FLCodeCodeGeneratorEnumLookup instance] inputTypeFromString:self.type];
}

- (void) setTypeAsEnum:(FLCodeInputType) inEnumValue
{
    self.type = [[FLCodeCodeGeneratorEnumLookup instance] stringFromInputType:inEnumValue];
}

// This sets/gets enum mask (stored/parsed as comma delimited string) as a NSSet. It uses [FLCodeCodeGeneratorEnumLookup instance] to lookup enums.
- (NSSet*) typeValues
{
    return [[FLCodeCodeGeneratorEnumLookup instance] enumsFromString:self.type];
}

- (void) setTypeValues:(NSSet*) values
{
    self.type = [[FLCodeCodeGeneratorEnumLookup instance] stringFromEnumSet:values];
}
@end

// [/Generated]

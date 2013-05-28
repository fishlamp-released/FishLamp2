// [Generated]
//
// This file was generated at 7/10/12 5:03 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCodeTypeDefinition.m
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCodeTypeDefinition.h"
#import "FLCodeEnums.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLCodeTypeDefinition


@synthesize dataType = __dataType;
@synthesize import = __import;
@synthesize importIsPrivate = __importIsPrivate;
@synthesize typeName = __typeName;
@synthesize typeNameUnmodified = __typeNameUnmodified;

- (void) dealloc
{
    FLRelease(__dataType);
    FLRelease(__typeName);
    FLRelease(__import);
    FLRelease(__typeNameUnmodified);
    FLSuperDealloc();
}

- (NSUInteger) hash
{
    return [[self typeName] hash] + [[self dataType] hash];
}

- (BOOL) isEqual:(id) object
{
    return [object isKindOfClass:[self class]] && [[object typeName] isEqual:[self typeName]] && [[object dataType] isEqual:[self dataType]];
}

+ (FLCodeTypeDefinition*) typeDefinition
{
    return FLAutorelease([[FLCodeTypeDefinition alloc] init]);
}

// This sets/gets single enum (stored as string) as value. It uses [FLCodeCodeGeneratorEnumLookup instance] to lookup enum
- (FLCodeTypeID) dataTypeAsEnum
{
    return [[FLCodeCodeGeneratorEnumLookup instance] dataTypeFromString:self.dataType];
}

- (void) setDataTypeAsEnum:(FLCodeTypeID) inEnumValue
{
    self.dataType = [[FLCodeCodeGeneratorEnumLookup instance] stringFromDataType:inEnumValue];
}

// This sets/gets enum mask (stored/parsed as comma delimited string) as a NSSet. It uses [FLCodeCodeGeneratorEnumLookup instance] to lookup enums.
- (NSSet*) dataTypeValues
{
    return [[FLCodeCodeGeneratorEnumLookup instance] enumsFromString:self.dataType];
}

- (void) setDataTypeValues:(NSSet*) values
{
    self.dataType = [[FLCodeCodeGeneratorEnumLookup instance] stringFromEnumSet:values];
}

@end


// [/Generated]

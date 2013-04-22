// [Generated]
//
// This file was generated at 5/31/12 5:54 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLDatabaseObject.m
// Project: FishLamp
// Schema: FLGeneratedCoreObject
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLDatabaseObject_Generated.h"
#import "FLObjectDescriber.h"

@implementation FLDatabaseObject_Generated

FLSynthesizeModelObjectMethods()

@synthesize identifier = __identifier;

+ (NSString*) identifierKey
{
    return @"identifier";
}

+ (id) databaseObject
{
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) dealloc
{
    FLRelease(__identifier);
    FLSuperDealloc();
}


- (id) init
{
    if((self = [super init]))
    {
    }
    return self;
}

@end

@implementation FLDatabaseObject_Generated (ValueProperties) 
@end

// [/Generated]

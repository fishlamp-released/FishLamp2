// [Generated]
//
// This file was generated at 7/9/12 1:47 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCodeStorageOptions.m
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCodeStorageOptions.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLCodeStorageOptions


@synthesize isIndexed = __isIndexed;
@synthesize isPrimaryKey = __isPrimaryKey;
@synthesize isRequired = __isRequired;
@synthesize isStorable = __isStorable;
@synthesize isUnique = __isUnique;

- (id) init
{
    if((self = [super init]))
    {
        self.isStorable = YES;
    }
    return self;
}

+ (FLCodeStorageOptions*) storageOptions
{
    return FLAutorelease([[FLCodeStorageOptions alloc] init]);
}

@end


// [/Generated]

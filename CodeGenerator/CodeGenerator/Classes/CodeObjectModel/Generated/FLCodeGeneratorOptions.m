// [Generated]
//
// This file was generated at 7/9/12 1:47 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCodeGeneratorOptions.m
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCodeGeneratorOptions.h"
#import "FLCodeDefine.h"

@implementation FLCodeGeneratorOptions


@synthesize comment = __comment;
@synthesize disabled = __disabled;
@synthesize generateAllIncludesFile = __generateAllIncludesFile;
@synthesize globalDefine = __globalDefine;

// Getter will create __globalDefine if nil. Alternately, use the globalDefineObject property, which will not lazy create it.
- (FLCodeDefine*) globalDefine
{
    if(!__globalDefine)
    {
        __globalDefine = [[FLCodeDefine alloc] init];
    }
    return __globalDefine;
}

@synthesize objectsFolderName = __objectsFolderName;
@synthesize typePrefix = __typePrefix;
@synthesize useGeneratedFolder = __useGeneratedFolder;

- (void) dealloc
{
    FLRelease(__typePrefix);
    FLRelease(__comment);
    FLRelease(__globalDefine);
    FLRelease(__objectsFolderName);
    FLSuperDealloc();
}

+ (FLCodeGeneratorOptions*) generatorOptions
{
    return FLAutorelease([[FLCodeGeneratorOptions alloc] init]);
}

// This returns __globalDefine. It does NOT create it if it's NIL.
- (FLCodeDefine*) globalDefineObject
{
    return __globalDefine;
}

- (void) createGlobalDefineIfNil
{
    if(!__globalDefine)
    {
        __globalDefine = [[FLCodeDefine alloc] init];
    }
}
@end

// [/Generated]

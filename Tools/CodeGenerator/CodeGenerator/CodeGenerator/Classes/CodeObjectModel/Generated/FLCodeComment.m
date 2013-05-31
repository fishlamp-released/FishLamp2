// [Generated]
//
// This file was generated at 7/9/12 1:47 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCodeComment.m
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCodeComment.h"

@implementation FLCodeComment

@synthesize comment = __comment;
@synthesize commentID = __commentID;
@synthesize object = __object;

+ (FLCodeComment*) comment
{
    return FLAutorelease([[FLCodeComment alloc] init]);
}


- (void) dealloc
{
    FLRelease(__object);
    FLRelease(__commentID);
    FLRelease(__comment);
    FLSuperDealloc();
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

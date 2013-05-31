// [Generated]
//
// FLCodeTypeDefinition.m
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//
// [/Generated]

#import "FLCodeTypeDefinition+Additions.h"

@implementation FLCodeTypeDefinition (Additions)
- (NSString*) description {
    return [NSString stringWithFormat:@"%@: type: %@, name: %@", [super description], self.dataType, self.typeName];
}

@end

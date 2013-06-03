// [Generated]
//
// FLCodeProject.m
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//
// [/Generated]

#import "FLXmlParser.h"
#import "FLCodeProject.h"

@implementation FLCodeProject (Additions)

- (NSString*) projectFolderPath {
//    return [[self.projectPath path] stringByDeletingLastPathComponent];

    return [self.projectPath stringByDeletingLastPathComponent];
}

@end

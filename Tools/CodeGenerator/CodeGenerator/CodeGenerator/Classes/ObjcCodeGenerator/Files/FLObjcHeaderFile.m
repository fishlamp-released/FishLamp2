//
//  FLObjcHeaderFile.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/31/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcHeaderFile.h"
#import "FLObjcCodeGeneratorHeaders.h"

@implementation FLObjcHeaderFile
- (BOOL) isHeaderFile {
    return YES;
}

+ (id) headerFile:(NSString*) rootFileName {
    return FLAutorelease([[[self class] alloc] initWithFileName:rootFileName]);
}

- (void) writeCodeToCodeBuilder:(FLObjcCodeBuilder*) codeBuilder {
    for(id<FLObjcCodeElement> codeElement in self.fileElements) {
        [codeElement writeCodeToHeaderFile:self withCodeBuilder:codeBuilder];
    }
}

- (void) setFileName:(NSString*) fileName {
    [super setFileName:[NSString stringWithFormat:@"%@.h", fileName]];
}

- (BOOL) canUpdateExistingFile {
    return YES;
}

- (NSString*) counterPartFileName {
    return [[self.fileName stringByDeletingPathExtension] stringByAppendingPathExtension:@"m"];
}

@end

//
//  FLObjcStatement.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcStatement.h"
#import "FLObjcType.h"

@implementation FLObjcStatement
//+ (id) objcStatement:(FLObjcTypeIndex*) typeIndex {
//    return FLAutorelease([[[self class] alloc] initWithTypeIndex:typeIndex]);
//}
- (void) writeCodeToHeaderFile:(FLObjcFile*) file withCodeBuilder:(FLObjcCodeBuilder*) codeBuilder {
}

- (void) writeCodeToSourceFile:(FLObjcFile*) file withCodeBuilder:(FLObjcCodeBuilder*) codeBuilder {
}

@end


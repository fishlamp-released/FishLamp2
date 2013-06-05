//
//  FLObjcCodeGenerator.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 2/3/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcCodeGenerator.h"
#import "FLObjcCodeGeneratorHeaders.h"

@interface FLObjcCodeGenerator ()
@end

@implementation FLObjcCodeGenerator

+ (id) objcCodeGenerator {
    return FLAutorelease([[[self class] alloc] init]);
}

- (FLCodeGeneratorResult*) generateCodeWithCodeProject:(FLCodeProject*) inputProject 
                                          fromLocation:(FLCodeProjectLocation*) location {

    FLObjcProject* project = [FLObjcProject objcProject];
    [project configureWithProjectInput:inputProject];
    return [project generateFiles];
}





@end



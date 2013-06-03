//
//  FLObjcUserHeaderFile.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/31/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcUserHeaderFile.h"
#import "FLObjcCodeGeneratorHeaders.h"

@implementation FLObjcUserHeaderFile
- (void) setFileName:(NSString*) fileName {
    [super setFileName:[NSString stringWithFormat:@"%@+User.h", fileName]];
}

@end
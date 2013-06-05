//
//  FLObjcUserSourceFile.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/31/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcUserSourceFile.h"


@implementation FLObjcUserSourceFile

- (void) setFileName:(NSString*) fileName {
    [super setFileName:[NSString stringWithFormat:@"%@+User.m", fileName]];
}

@end

//
//  FLRunTestsToolTask.m
//  Fluffy
//
//  Created by Mike Fullerton on 11/15/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLRunTestsToolTask.h"

@implementation FLRunTestsToolTask

+ (NSArray*) defaultInputKeys {
    return [NSArray arrayWithObjects:@"-t", @"--test", nil];
}

@end

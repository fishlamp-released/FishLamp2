//
//  FLRunTestsToolTask.m
//  Fluffy
//
//  Created by Mike Fullerton on 11/15/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLSyncFolderTask.h"

@implementation FLSyncFolderTask

- (NSArray*) argumentKeys {
    return [NSArray arrayWithObjects:@"-f", @"--folder", nil];
}

- (void) runWithArgument:(FLCommandLineArgument*) arg inTool:(FLTool*) tool {
}

@end

//
//  FLRunTestsToolTask.m
//  Fluffy
//
//  Created by Mike Fullerton on 11/15/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLSyncFolderTask.h"

@implementation FLSyncFolderTask

- (NSArray*) argumentKeys {
    return [NSArray arrayWithObjects:@"-f", @"--folder", nil];
}

- (void) runWithArgument:(FLCommandLineArgument*) arg inTool:(FLTool*) tool {
}

@end

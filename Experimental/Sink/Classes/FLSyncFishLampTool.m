//
//  FLFluffyTool.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/22/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLSyncFishLampTool.h"
#import "FLUsageTask.h"
#import "FLSyncFolderTask.h"

@implementation FLSyncFishLampTool

- (id<FLCommandLineParser>) toolWillRun:(FLTool*) tool {
    tool.toolName = @"SyncFishLamp";
    [tool setDefaultToolTask:[FLUsageTask toolTask]];
    [tool addToolTask:[FLSyncFolderTask toolTask]];
    return [FLCommandLineParser create];
}

@end

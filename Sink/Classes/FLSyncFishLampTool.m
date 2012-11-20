//
//  FLFluffyTool.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/22/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLSyncFishLampTool.h"
#import "FLUsageTask.h"
#import "FLSyncFolderTask.h"

@implementation FLSyncFishLampTool

- (id<FLCommandLineParser>) toolWillRun:(FLTool*) tool {
    tool.toolName = @"SyncFishLamp";
    [tool addToolTask:[FLUsageTask toolTask]];
    [tool addToolTask:[FLSyncFolderTask toolTask]];
    return [FLCommandLineParser create];
}

@end

//
//  FLUsageTask.m
//  FishLampCommandLineTool
//
//  Created by Mike Fullerton on 11/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLUsageTask.h"
#import "FLTool.h"

@implementation FLUsageTask

- (id) init {
    self = [super init];
    if(self) {
    
    }
    
    return self;
}

- (NSArray*) argumentKeys {
    return [NSArray arrayWithObjects:@"-u", @"--usage", nil];
}

- (void) runWithArgument:(FLCommandLineArgument*) argument inTool:(FLTool*) tool {
   FLLog(@"Usage for %@", tool.toolName);
}

@end

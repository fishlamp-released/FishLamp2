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

- (NSArray*) parameterKeys {
    return [NSArray arrayWithObjects:@"-u", @"--usage", nil];
}

- (void) startWorking:(id) asyncTask {

    FLLog(@"Usage for %@", self.parentTool.toolName);

    [asyncTask setFinished];

}

@end

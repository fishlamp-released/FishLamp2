//
//  FLTestResult.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/18/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FLTestResult <NSObject>
@property (readonly, assign) BOOL didRun;
@property (readonly, assign) BOOL didPass;
@property (readonly, strong) NSString* testName;

- (NSString*) runSummary;
- (NSString*) failureDescription;
@end


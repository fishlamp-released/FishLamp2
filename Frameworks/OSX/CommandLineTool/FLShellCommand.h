//
//  FLShellCommand.h
//  FishLampOSXTool
//
//  Created by Mike Fullerton on 5/27/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FishLampCore.h"
#import "FLOperation.h"
#import "FLCommandLineArgument.h"

@interface FLShellCommand : FLOperation {
@private
    NSString* _launchPath;
    NSMutableArray* _args;
    NSDictionary* _environment;
}
@property (readwrite, strong, nonatomic) NSDictionary* environment;

- (id) initWithLaunchPath:(NSString*) path;
+ (id) shellCommand:(NSString*) path;

- (void) addArgument:(FLCommandLineArgument*) arg;

+ (NSDictionary*) sshEnvironmentVariables;

- (void) willStartTask:(NSTask*) task;

@end

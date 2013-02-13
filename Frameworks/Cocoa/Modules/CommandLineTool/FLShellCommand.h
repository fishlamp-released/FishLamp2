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

#if OSX
@interface FLShellCommand : FLOperation {
@private
    NSString* _launchPath;
    NSMutableArray* _args;
}

- (id) initWithLaunchPath:(NSString*) path;
+ (id) shellCommand:(NSString*) path;

- (void) addArgument:(FLCommandLineArgument*) arg;

@end
#endif
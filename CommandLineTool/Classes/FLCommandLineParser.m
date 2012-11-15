//
//  FLCommandLineParser.m
//  FishLampCommandLineTool
//
//  Created by Mike Fullerton on 11/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCommandLineParser.h"

@implementation FLCommandLineParser

- (NSArray*) parseArguments:(NSArray*) arrayOfStrings {
    NSMutableArray* arguments = [NSMutableArray array];
    for(NSString* string in arrayOfStrings) {
        if([string hasPrefix:@"-"] || arguments.count == 0) {
            FLCommandLineArgument* arg = [FLCommandLineArgument commandLineArgument:string];
            [arguments addObject:arg];
        }
        else {
            [[arguments lastObject] addValue:string];
        }
    }
    
    return arguments;
}

@end

NSArray* FLCommandLineArguments(int argc, const char * argv[]) {
    
    NSMutableArray* inputStrings = [NSMutableArray arrayWithCapacity:argc];
    for(int i = 0; i < argc; i++) {
        [inputStrings addObject:[NSString stringWithCString:argv[i] encoding:NSASCIIStringEncoding]];
    }
    
    return inputStrings;
}
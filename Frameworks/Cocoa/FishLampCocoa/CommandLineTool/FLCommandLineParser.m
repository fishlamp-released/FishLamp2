//
//  FLCommandLineParser.m
//  FishLampCommandLineTool
//
//  Created by Mike Fullerton on 11/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCommandLineParser.h"

@implementation FLCommandLineParser

+ (id) commandLineParser {
    return autorelease_([[[self class] alloc] init]);
}

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


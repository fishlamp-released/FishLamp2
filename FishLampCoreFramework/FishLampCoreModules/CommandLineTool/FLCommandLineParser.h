//
//  FLCommandLineParser.h
//  FishLampCommandLineTool
//
//  Created by Mike Fullerton on 11/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLCommandLineArgument.h"

@protocol FLCommandLineParser <NSObject>
- (NSArray*) parseArguments:(NSArray*) arrayOfStrings;
@end

@interface FLCommandLineParser : NSObject<FLCommandLineParser>
@end

extern NSArray* FLCommandLineArguments(int argc, const char * argv[]);
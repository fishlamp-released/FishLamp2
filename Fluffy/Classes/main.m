//
//  main.m
//  Fluffy
//
//  Created by Mike Fullerton on 6/21/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLFluffyTool.h"
#import "FLCommandLineParser.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        FLFluffyTool* tool = autorelease_([[FLFluffyTool alloc] init]);
        return [tool runWithParameters: FLCommandLineArguments(argc, argv)];
    }
}



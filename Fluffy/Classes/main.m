//
//  main.m
//  Fluffy
//
//  Created by Mike Fullerton on 6/21/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FluffyApp.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        return FLCommandLineToolMain(argc, argv, [FluffyApp class], @"FluffyApp");
    }
}



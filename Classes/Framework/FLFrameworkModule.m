//
//  FLFrameworkModule.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/12/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLFrameworkModule.h"

@implementation FLFrameworkModule

- (void) initializeModule {
}

+ (void) initializeModule {

    static NSMutableSet* s_modules = nil;
    if(!s_modules) {
        s_modules = [[NSMutableSet alloc] init];
    }

    if(![s_modules containsObject:[self class]]) {
        id module = [[[self class] alloc] init];
        [module initializeModule];
        FLRelease(module);
    }
}


@end

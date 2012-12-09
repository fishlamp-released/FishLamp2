//
//  FishLampXcodePlugin.m
//  FishLampXcodePlugin
//
//  Created by Mike Fullerton on 12/9/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FishLampXcodePlugin.h"

@implementation FishLampXcodePlugin

- (id) init {
    self = [super init];
    if(self) {
        [self insertPluginMenuInMainMenu:@"FishLamp"];
        
        NSLog(@"Hello world");
    }
    return self;
}


@end

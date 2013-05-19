//
//  FishLampXcodePlugin.m
//  FishLampXcodePlugin
//
//  Created by Mike Fullerton on 12/9/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FishLampXcodePlugin.h"

@implementation FishLampXcodePlugin

- (void) testItem:(id) selector {

}

- (id) init {
    self = [super init];
    if(self) {
        [self insertPluginMenuInMainMenu:@"FishLamp"];
        
        NSLog(@"Hello world");
        
		NSMenuItem *viewMenuItem = [[NSApp mainMenu] itemWithTitle:@"View"];
		if (viewMenuItem) {
			[[viewMenuItem submenu] addItem:[NSMenuItem separatorItem]];
			NSMenuItem *toggleSchemeInTitleBarItem = [[[NSMenuItem alloc] initWithTitle:@"fishlamp" action:@selector(testItem:) keyEquivalent:@""] autorelease];
			[[viewMenuItem submenu] addItem:toggleSchemeInTitleBarItem];
		}
    }
    return self;
}



+ (void)pluginDidLoad:(NSBundle *)plugin {
        NSLog(@"Hello world");
    
    NSBeep();

    [[[self class] instance]pluginDidLoad:plugin];
}

@end

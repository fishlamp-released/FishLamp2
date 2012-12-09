//
//  FLXcodePlugin.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/9/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLXcodePlugin.h"

@implementation FLXcodePlugin
FLSynthesizeSingleton(FLXcodePlugin);

@synthesize pluginBundle = _pluginBundle;

#if FL_MRC
- (void) dealloc {
    [_pluginBundle release];
    [super dealloc];
}
#endif

- (void) pluginDidLoad:(NSBundle *)plugin {
    _pluginBundle = FLRetain(plugin);
}

+ (void)pluginDidLoad:(NSBundle *)plugin {
        NSLog(@"Hello world");


    [[[self class] instance]pluginDidLoad:plugin];
}

- (void) testItem:(id) sender {
}

- (NSMenuItem*) insertPluginMenuInMainMenu:(NSString*) title {


		NSMenuItem *viewMenuItem = [[NSApp mainMenu] itemWithTitle:@"View"];
		if (viewMenuItem) {
			[[viewMenuItem submenu] addItem:[NSMenuItem separatorItem]];
			NSMenuItem *toggleSchemeInTitleBarItem = [[[NSMenuItem alloc] initWithTitle:@"FishLamp" action:@selector(testItem:) keyEquivalent:@""] autorelease];
			[[viewMenuItem submenu] addItem:toggleSchemeInTitleBarItem];
		}

    return [[NSApp mainMenu] addItemWithTitle:title action:nil keyEquivalent:@""];
    
//    return [[NSApp mainMenu] insertItemWithTitle:title action:nil keyEquivalent:nil atIndex:[[NSApp mainMenu] numberOfItems] - 1];
    
//		if (viewMenuItem) {
//			[[viewMenuItem submenu] addItem:[NSMenuItem separatorItem]];
//			NSMenuItem *toggleSchemeInTitleBarItem = [[[NSMenuItem alloc] initWithTitle:@"Scheme Selection in Title Bar" action:@selector(toggleSchemeInTitleBar:) keyEquivalent:@""] autorelease];
//			[toggleSchemeInTitleBarItem setTarget:self];
//			[[viewMenuItem submenu] addItem:toggleSchemeInTitleBarItem];
//		}

}

@end

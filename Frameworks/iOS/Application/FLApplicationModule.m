//
//  FLApplicationModule.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/12/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLApplicationModule.h"
#import "FLKeyboardManager.h"
#import "FLRandom.h"
#import "FLLowMemoryHandler.h"
#import "FLDefaultUserNotificationErrorFormatters.h"

@implementation FLApplicationModule

- (void) initializeModule {
	FLSetRandomSeed();
	
#if DEBUG	
	if(getenv("NSZombieEnabled") || getenv("NSAutoreleaseFreedObjectCheckEnabled")) {
		FLLog(@"NSZombieEnabled/NSAutoreleaseFreedObjectCheckEnabled enabled!");
	}
#endif
  
// This is experimental
// TODO: finish this	  
//	  FLInstallUncaughtExceptionHandler();
	
    // NOTE if app crashes here, it probably means you need to add "-ObjC" option to linker flags. 
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];	
 
// low memory handling		
// TODO: maybe get rid of this
	[[FLLowMemoryHandler defaultHandler] registerForEvents];
	
// error message formatters	
// TODO: abstract this so it's not coupled?   
	InstallDefaultUserNotificationErrorFormatters();
		
	[[FLKeyboardManager instance] startWatchingKeyboard];
}

@end

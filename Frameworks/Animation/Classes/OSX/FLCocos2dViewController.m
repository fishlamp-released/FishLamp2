//
//  FLCocos2dViewController.m
//  FishLampAnimation
//
//  Created by Mike Fullerton on 4/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCocos2dViewController.h"

@interface FLCocos2dViewController ()

@end

@implementation FLCocos2dViewController

+ (void) initialize {
    FLInitCocos2d();
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void) awakeFromNib {
    //Check to see if the view is empty prior to launching
    CCDirectorMac *director = (CCDirectorMac*) [CCDirector sharedDirector];
    // enable FPS and SPF
    [director setDisplayStats:YES];

    FLAssert([self.view isKindOfClass:[CCGLView class]]);

    // connect the OpenGL view with the director
    [director setView:(CCGLView*) self.view];
    director.delegate = self;

    // EXPERIMENTAL stuff.
    // 'Effects' don't work correctly when autoscale is turned on.
    // Use kCCDirectorResize_NoScale if you don't want auto-scaling.

    [director setResizeMode:kCCDirectorResize_AutoScale];

    // Enable "moving" mouse event. Default no.
//    [self.window setAcceptsMouseMovedEvents:NO];
//
//    // Center main window
//    [self.window center];

//    CCScene *scene = [CCScene node];
//
//    [scene addChild:[PuzzleWorld node]];


    // Run whatever scene we'd like to run here.
//    if(director.runningScene) {
//        [director replaceScene:scene];
//    }
//    else {
//        [director runWithScene:scene];
//    }

}

- (void) dealloc {
    [CCDirector sharedDirector].delegate = nil;
	[[CCDirector sharedDirector] end];
#if FL_MRC
	[super dealloc];
#endif
}

/// move this?
- (IBAction)toggleFullScreen: (id)sender
{
	CCDirectorMac *director = (CCDirectorMac*) [CCDirector sharedDirector];
	[director setFullScreen: ! [director isFullScreen] ];
}


@end

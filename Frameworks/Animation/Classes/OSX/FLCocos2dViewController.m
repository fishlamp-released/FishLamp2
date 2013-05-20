//
//  FLCocos2dViewController.m
//  FishLampAnimation
//
//  Created by Mike Fullerton on 4/19/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocos2dViewController.h"
#import "HelloWorldLayer.h"


@interface FLCocos2dViewController ()
@end

@implementation FLCocos2dViewController
@synthesize delegate = _delegate;

+ (void) initialize {
    FLInitCocos2d();
}


- (void) cocos2dViewDidMoveToWindow:(NSView*) view {

    FLAssert([self.view isKindOfClass:[CCGLView class]]);

    CCDirectorMac* director = self.director;

    static BOOL initialized = NO;
    if(!initialized) {
        initialized = YES;
        // connect the OpenGL view with the director
        [director setView:(CCGLView*) self.view];
        director.delegate = self;
        [self.delegate cocos2dViewController:self didPrepareCocos2d:director];
    }
}

- (void) dealloc {
    [CCDirector sharedDirector].delegate = nil;
	[[CCDirector sharedDirector] end];
#if FL_MRC
	[super dealloc];
#endif
}

- (CCDirectorMac*) director {
    return (CCDirectorMac*) [CCDirector sharedDirector];
}

- (IBAction)toggleFullScreen: (id)sender {
	CCDirectorMac *director = (CCDirectorMac*) [CCDirector sharedDirector];
	[director setFullScreen: ! [director isFullScreen] ];
}


@end

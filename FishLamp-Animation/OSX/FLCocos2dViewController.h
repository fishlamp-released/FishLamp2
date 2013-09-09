//
//  FLCocos2dViewController.h
//  FishLampAnimation
//
//  Created by Mike Fullerton on 4/19/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocos2d.h"
#import "FLCocos2dView.h"

// NOTE: the view must be a FLCocos2dViw

@protocol FLCocos2dViewControllerDelegate;

@interface FLCocos2dViewController : NSViewController<CCDirectorDelegate, FLCocos2dViewDelegate> {
@private
    IBOutlet __unsafe_unretained id _delegate;
}

@property (readonly, assign, nonatomic) CCDirectorMac* director;

@property (readwrite, nonatomic, assign) id<FLCocos2dViewControllerDelegate> delegate;

- (IBAction)toggleFullScreen: (id)sender;

@end

@protocol FLCocos2dViewControllerDelegate <NSObject>

- (void) cocos2dViewController:(FLCocos2dViewController*) controller 
             didPrepareCocos2d:(CCDirectorMac*) director;
@end

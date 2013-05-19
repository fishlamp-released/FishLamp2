//
//	FLSlideShowOptionsViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/8/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLEditObjectViewController.h"
#import "FLSlideshowOptions.h"

@protocol FLSlideshowOptionsViewControllerDelegate;

@interface FLSlideshowOptionsViewController : FLEditObjectViewController<MPMediaPickerControllerDelegate> {
@private
	FLSlideshowOptions* _options;
	__unsafe_unretained id<FLSlideshowOptionsViewControllerDelegate> _slideshowDelegate;
	BOOL _showButton;
}

- (id) initWithSlideshowOptions:(FLSlideshowOptions*) options showStartNowButton:(BOOL) showStartNowButton;

+ (FLSlideshowOptionsViewController*) slideshowOptionsViewController:(FLSlideshowOptions*) options showStartNowButton:(BOOL) showStartNowButton;

@property (readonly, retain, nonatomic) FLSlideshowOptions* options;
@property (readwrite, assign, nonatomic) id<FLSlideshowOptionsViewControllerDelegate> slideshowOptionsDelegate;

- (void) addOptionsToBuilder:(FLTableViewLayoutBuilder*) builder;
- (void) addBeginButtonToBuilder:(FLTableViewLayoutBuilder*) builder;

@end

@protocol FLSlideshowOptionsViewControllerDelegate <NSObject>
- (void) slideshowOptionsViewController:(FLSlideshowOptionsViewController*) viewController
	beginSlideshowWithOptions:(FLSlideshowOptions*) options;
@end
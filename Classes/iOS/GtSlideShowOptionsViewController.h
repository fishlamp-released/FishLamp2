//
//	GtSlideShowOptionsViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/8/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtEditObjectViewController.h"
#import "GtSlideshowOptions.h"

@protocol GtSlideshowOptionsViewControllerDelegate;

@interface GtSlideshowOptionsViewController : GtEditObjectViewController<MPMediaPickerControllerDelegate> {
@private
	GtSlideshowOptions* m_options;
	id<GtSlideshowOptionsViewControllerDelegate> m_slideshowDelegate;
	BOOL m_showButton;
}

- (id) initWithSlideshowOptions:(GtSlideshowOptions*) options showStartNowButton:(BOOL) showStartNowButton;

+ (GtSlideshowOptionsViewController*) slideshowOptionsViewController:(GtSlideshowOptions*) options showStartNowButton:(BOOL) showStartNowButton;

@property (readonly, retain, nonatomic) GtSlideshowOptions* options;
@property (readwrite, assign, nonatomic) id<GtSlideshowOptionsViewControllerDelegate> slideshowOptionsDelegate;

- (void) addOptionsToBuilder:(GtTableViewLayoutBuilder*) builder;
- (void) addBeginButtonToBuilder:(GtTableViewLayoutBuilder*) builder;

@end

@protocol GtSlideshowOptionsViewControllerDelegate <NSObject>
- (void) slideshowOptionsViewController:(GtSlideshowOptionsViewController*) viewController
	beginSlideshowWithOptions:(GtSlideshowOptions*) options;
@end
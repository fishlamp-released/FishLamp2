//
//	FLSlideShowOptionsViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/8/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLEditObjectViewController.h"
#import "FLSlideshowOptions.h"

@protocol FLSlideshowOptionsViewControllerDelegate;

@interface FLSlideshowOptionsViewController : FLEditObjectViewController<MPMediaPickerControllerDelegate> {
@private
	FLSlideshowOptions* m_options;
	id<FLSlideshowOptionsViewControllerDelegate> m_slideshowDelegate;
	BOOL m_showButton;
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
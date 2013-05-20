//
//	GtProgressView.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/21/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtProgressProtocol.h"
#import "GtModalView.h"

@class GtButton;
@class GtRoundRectView;

@interface GtProgressView : GtModalView<GtProgressProtocol> {
@private
	UILabel* m_progressBarLabel;
	UILabel* m_titleLabel;
	UILabel* m_secondaryTextLabel;
	UIProgressView* m_progressBar;
	UIActivityIndicatorView* m_progressBarSpinner;
	GtButton* m_button;
	GtRoundRectView* m_roundRectView;
	id m_buttonTarget;
	SEL m_buttonWasPressedCallback;
	
	struct {
		unsigned int isModal:1;
		unsigned int inPopover: 1;
		unsigned int buttonIsCancelButton:1;
	} m_progressViewFlags;
	
	NSTimeInterval m_startDelay;
}

// views
@property (readwrite, retain, nonatomic) UILabel* titleLabel;
@property (readwrite, retain, nonatomic) UILabel* secondaryTextLabel;
@property (readwrite, retain, nonatomic) UILabel* progressBarLabel;
@property (readwrite, retain, nonatomic) UIProgressView* progressBar;
@property (readwrite, retain, nonatomic) UIActivityIndicatorView* progressBarSpinner;
@property (readwrite, retain, nonatomic) GtButton* button;
@property (readwrite, retain, nonatomic) GtRoundRectView* roundRectView;

@property (readwrite, assign, nonatomic, getter=isModal) BOOL modal; 

- (void) willStartUpdatingProgressBar;

@end


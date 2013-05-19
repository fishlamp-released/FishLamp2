//
//	FLProgressView.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/21/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

@class FLLegacyButton;
@class FLRoundRectView;

@interface FLLegacyProgressView : UIView {
@private
	UILabel* _progressBarLabel;
	UILabel* _titleLabel;
	UILabel* _secondaryTextLabel;
	UIProgressView* _progressBar;
	UIActivityIndicatorView* _progressBarSpinner;
	FLLegacyButton* _button;
	FLRoundRectView* _roundRectView;
	id _buttonTarget;
	SEL _buttonWasPressedCallback;
	
	struct {
		unsigned int isModal:1;
		unsigned int inPopover: 1;
		unsigned int buttonIsCancelButton:1;
	} _progressViewFlags;
}

// views
@property (readwrite, retain, nonatomic) UILabel* titleLabel;
@property (readwrite, retain, nonatomic) UILabel* secondaryTextLabel;
@property (readwrite, retain, nonatomic) UILabel* progressBarLabel;
@property (readwrite, retain, nonatomic) UIProgressView* progressBar;
@property (readwrite, retain, nonatomic) UIActivityIndicatorView* progressBarSpinner;
@property (readwrite, retain, nonatomic) FLLegacyButton* button;
@property (readwrite, retain, nonatomic) FLRoundRectView* roundRectView;

- (void) willStartUpdatingProgressBar;

- (void) setProgressBarText:(NSString*) text;

@end


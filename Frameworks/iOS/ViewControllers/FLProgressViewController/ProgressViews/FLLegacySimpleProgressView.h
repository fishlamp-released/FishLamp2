//
//	FLLegacyProgressView.h
//	FishLamp
//
//	Created by Mike Fullerton on 5/22/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLRoundRectView.h"
#import "FLLegacyButton.h"

typedef struct FLProgressStyleStruct {
	unsigned int hasSecondaryText: 1;
	unsigned int hasProgressBar: 1;
	unsigned int canDrag: 1;
	unsigned int isModal: 1;
	unsigned int maximizeWidth:1;
	unsigned int buttonIsCancel:1;
} FLProgressStyleStruct;   

extern const FLProgressStyleStruct FLProgressStyleStructEmpty;

@interface FLLegacySimpleProgressView : UIView	{
@private
// subviews
	UILabel* _textLabel;
	UIActivityIndicatorView* _spinner;
	UIActivityIndicatorView* _progressBarSpinner;
	UIProgressView* _progressBar;
	UIView* _dragBar;
	UILabel* _progressBarTextLabel;
	FLRoundRectView* _roundRectView;
	
// state
	CGFloat _opacity; // used in dragging
	FLProgressStyleStruct _style;
	
	struct { 
		unsigned int dragging:1;
	} _progressFlags;
}

- (id) initDefaultProgress;

- (id) initDefaultModalProgress;

+ (FLLegacySimpleProgressView*) progressView:(BOOL) hasProgressBar
	hasSecondaryText:(BOOL) hasSecondaryText
	canDrag:(BOOL) canDrag
	maximizeWidth:(BOOL) maximizeWith;

+ (FLLegacySimpleProgressView*) modalProgressView:(BOOL) hasProgressBar
	hasSecondaryText:(BOOL) hasSecondaryText
	canDrag:(BOOL) canDrag
	maximizeWidth:(BOOL) maximizeWith;

+ (FLLegacySimpleProgressView*) defaultProgressView;
+ (FLLegacySimpleProgressView*) defaultModalProgressView;

@property (readonly, assign, nonatomic) BOOL isModal;
@property (readonly, assign, nonatomic) BOOL hasProgressBar;
@property (readonly, assign, nonatomic) BOOL canDrag;
@property (readonly, assign, nonatomic) BOOL maximizeWidth;
@property (readonly, assign, nonatomic) BOOL hasSecondaryText;

// subviews
@property (readonly, retain, nonatomic) UIProgressView* progressBar;
@property (readonly, retain, nonatomic) UILabel* textLabel;
@property (readonly, retain, nonatomic) UILabel* progressBarTextLabel;
@property (readonly, retain, nonatomic) FLRoundRectView* roundRectView;

@end



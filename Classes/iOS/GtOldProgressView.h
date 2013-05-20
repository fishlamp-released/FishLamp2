//
//	GtOldProgressView.h
//	FishLamp
//
//	Created by Mike Fullerton on 5/22/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtRoundRectView.h"
#import "GtWeakReference.h"
//#import "GtProgressValue.h"
#import "GtProgressProtocol.h"
#import "GtModalView.h"
#import "GtButton.h"

typedef struct GtProgressStyleStruct {
	unsigned int hasSecondaryText: 1;
	unsigned int hasProgressBar: 1;
	unsigned int canDrag: 1;
	unsigned int isModal: 1;
	unsigned int maximizeWidth:1;
	unsigned int buttonIsCancel:1;
} GtProgressStyleStruct;   

extern const GtProgressStyleStruct GtProgressStyleStructEmpty;

#define GtCastToProgressView(__p__) ((GtOldProgressView*)__p__)

@interface GtOldProgressView : GtModalView<GtProgressProtocol>	{
@private
// subviews
	UILabel* m_textLabel;
	UIActivityIndicatorView* m_spinner;
	UIActivityIndicatorView* m_progressBarSpinner;
	UIProgressView* m_progressBar;
	UIView* m_dragBar;
	UILabel* m_progressBarTextLabel;
	GtRoundRectView* m_roundRectView;
	
// state
	CGFloat m_opacity; // used in dragging
	GtProgressStyleStruct m_style;
	
	struct { 
		unsigned int dragging:1;
	} m_progressFlags;
	
	NSTimeInterval m_startDelay;
}

- (id) initDefaultProgress;

- (id) initDefaultModalProgress;

+ (GtOldProgressView*) progressView:(BOOL) hasProgressBar
	hasSecondaryText:(BOOL) hasSecondaryText
	canDrag:(BOOL) canDrag
	maximizeWidth:(BOOL) maximizeWith;

+ (GtOldProgressView*) modalProgressView:(BOOL) hasProgressBar
	hasSecondaryText:(BOOL) hasSecondaryText
	canDrag:(BOOL) canDrag
	maximizeWidth:(BOOL) maximizeWith;

+ (GtOldProgressView*) defaultProgressView;
+ (GtOldProgressView*) defaultModalProgressView;

@property (readonly, assign, nonatomic) BOOL isModal;
@property (readonly, assign, nonatomic) BOOL hasProgressBar;
@property (readonly, assign, nonatomic) BOOL canDrag;
@property (readonly, assign, nonatomic) BOOL maximizeWidth;
@property (readonly, assign, nonatomic) BOOL hasSecondaryText;

// subviews
@property (readonly, retain, nonatomic) UIProgressView* progressBar;
@property (readonly, retain, nonatomic) UILabel* textLabel;
@property (readonly, retain, nonatomic) UILabel* progressBarTextLabel;
@property (readonly, retain, nonatomic) GtRoundRectView* roundRectView;

@end



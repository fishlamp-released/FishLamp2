//
//  GtProgressHandler.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/17/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtBusyView.h"
#import "GtWeakReference.h"

typedef enum {
    GtProgressLocationCentered,
	GtProgressLocationLowerRight,
	GtProgressLocationLowerRightAboveToolbar,
	GtProgressLocationLowerRightAboveTabBar,
	GtProgressLocationCurrentPosition
} GtProgressLocation;

@interface GtProgressHandler : NSObject<GtWeaklyReferencedObject> {
@private
	UIView* m_superview; 
	UIView* m_customView;
	NSString* m_busyText;
	GtBusyView* m_busyView;
	NSString* m_buttonText;
	CGFloat m_opacity; 
	
	id m_buttonTarget;
	SEL m_buttonAction;
	
	struct 
	{
		unsigned int isModal:1;
		unsigned int wantsProgressBar:1;
		unsigned int location:4;
	} m_flags;

    GtDeclareWeakRefMember();
}

@property (readonly, assign, nonatomic) GtBusyView* busyView;

@property (readwrite, assign, nonatomic) CGFloat opacity;
@property (readwrite, assign, nonatomic) BOOL isModal;
@property (readwrite, assign, nonatomic) BOOL wantsProgressBar;

@property (readwrite, assign, nonatomic) UIView* customView;
@property (readwrite, assign, nonatomic) UIView* superview;
@property (readwrite, assign, nonatomic) NSString* text;

@property (readwrite, assign, nonatomic) GtProgressLocation location;

// button info
- (void) removeButton;
- (void) setButtonInfo:(NSString*) buttonText 
		  buttonTarget:(id) buttonTarget 
	      buttonAction:(SEL) buttonAction;
@property (readonly, assign, nonatomic) NSString* buttonText;
@property (readonly, assign, nonatomic) id buttonTarget;
@property (readonly, assign, nonatomic) SEL buttonAction;

// state
- (void) startProgress;
- (void) stopProgress;
- (BOOL) isShowingProgress;

// this is the progress bar
- (void) updateProgress:(CGFloat) value;

// reset all the values to default (except location)
- (void) reset;

@end

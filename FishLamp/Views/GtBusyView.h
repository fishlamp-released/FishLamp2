//
//  GtBusyView.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/22/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#import "GtRoundRectView.h"
#import "GtEventEaterView.h"
#import "GtWeakReference.h"

@class GtProgressHandler;

@interface GtBusyView : GtRoundRectView  {
@private
	UILabel* m_textLabel; // not retained
	UIActivityIndicatorView* m_spinner; // not retained
	UIProgressView* m_progressView;
	UIButton* m_button;
	GtEventEaterView* m_shieldView;
    GtWeakReference* m_info;

// TODO: use struct
	BOOL m_animateClose;
    BOOL m_canDrag;
    CGFloat m_opacity;
}

- (id) initWithProgressHandler:(GtProgressHandler*) info;

- (void) setup:(GtProgressHandler*) info;

- (void) setDone:(BOOL) animate;

- (void) setBusyText:(NSString*) text;

- (void) updateProgress:(CGFloat) value;

@end

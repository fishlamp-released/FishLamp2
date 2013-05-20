//
//	GtTextEditingBar.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/6/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "GtTextEditCell.h"

@protocol GtTextEditingBarDelegate;

@interface GtTextEditingBar : UIToolbar {
@private
	id<GtTextEditingBarDelegate> m_delegate;
	UIBarButtonItem* m_next;
	UIBarButtonItem* m_prev;
	UIBarButtonItem* m_stop;
}

- (void) showWithKeyboardRect:(CGRect) keyboardRect;
- (void) slideOffscreen;
- (void) update;

@property (readwrite, assign, nonatomic) id<GtTextEditingBarDelegate> delegate;
@end

@protocol GtTextEditingBarDelegate <NSObject>
- (void) textEditingBarNextButtonPressed:(GtTextEditingBar*) bar;
- (void) textEditingBarPreviousButtonPressed:(GtTextEditingBar*) bar;
- (void) textEditingBarCancelButtonPressed:(GtTextEditingBar*) bar;
- (BOOL) textEditingBarNextButtonEnabled:(GtTextEditingBar*) bar;
- (BOOL) textEditingBarPreviousButtonEnabled:(GtTextEditingBar*) bar;
@end

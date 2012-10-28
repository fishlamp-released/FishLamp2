//
//	FLTextEditingBar.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/6/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLTextEditCell.h"

@protocol FLTextEditingBarDelegate;

@interface FLTextEditingBar : UIToolbar {
@private
	__unsafe_unretained id<FLTextEditingBarDelegate> _textEditingBarDelegate;
	UIBarButtonItem* _next;
	UIBarButtonItem* _prev;
	UIBarButtonItem* _stop;
}

- (void) showWithKeyboardRect:(FLRect) keyboardRect;
- (void) slideOffscreen;
- (void) update;

@property (readwrite, assign, nonatomic) id<FLTextEditingBarDelegate> delegate;
@end

@protocol FLTextEditingBarDelegate <NSObject>
- (void) textEditingBarNextButtonPressed:(FLTextEditingBar*) bar;
- (void) textEditingBarPreviousButtonPressed:(FLTextEditingBar*) bar;
- (void) textEditingBarCancelButtonPressed:(FLTextEditingBar*) bar;
- (BOOL) textEditingBarNextButtonEnabled:(FLTextEditingBar*) bar;
- (BOOL) textEditingBarPreviousButtonEnabled:(FLTextEditingBar*) bar;
@end

//
//	FLTextEditingBar.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/6/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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

- (void) showWithKeyboardRect:(CGRect) keyboardRect;
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

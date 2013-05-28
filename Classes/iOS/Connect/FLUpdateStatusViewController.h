//
//  FLUpdateStatusViewController.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/14/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLTextEditViewController.h"
#import "FLUserHeaderView.h"

@interface FLUpdateStatusViewController : FLTextEditViewController {
@private 
	UIToolbar* _editingBar;
	__unsafe_unretained FLDeprecatedButtonbarView* _textEditingBar;
	FLUserHeaderView* _headerView;
}

@property (readonly, retain, nonatomic) FLUserHeaderView* userHeaderView;
@property (readonly, assign, nonatomic) FLDeprecatedButtonbarView* textEditingButtonbar;

+ (FLUpdateStatusViewController*) updateStatusViewController;

- (void) shortenLinks;
- (void) clearText;

- (void) beginLoadingForUserHeader;

@end

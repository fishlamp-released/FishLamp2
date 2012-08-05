//
//  FLUpdateStatusViewController.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/14/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLTextEditViewController.h"
#import "FLUserHeaderView.h"

@interface FLUpdateStatusViewController : FLTextEditViewController {
@private 
	UIToolbar* m_editingBar;
	FLButtonbarView* m_textEditingBar;
	FLUserHeaderView* m_headerView;
}

@property (readonly, retain, nonatomic) FLUserHeaderView* userHeaderView;
@property (readonly, assign, nonatomic) FLButtonbarView* textEditingButtonbar;

+ (FLUpdateStatusViewController*) updateStatusViewController;

- (void) shortenLinks;
- (void) clearText;

- (void) beginLoadingForUserHeader;

@end

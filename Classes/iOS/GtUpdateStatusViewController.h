//
//  GtUpdateStatusViewController.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/14/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtTextEditViewController.h"
#import "GtUserHeaderView.h"

@interface GtUpdateStatusViewController : GtTextEditViewController {
@private 
	UIToolbar* m_editingBar;
	GtButtonbarView* m_textEditingBar;
	GtUserHeaderView* m_headerView;
}

@property (readonly, retain, nonatomic) GtUserHeaderView* userHeaderView;
@property (readonly, assign, nonatomic) GtButtonbarView* textEditingButtonbar;

+ (GtUpdateStatusViewController*) updateStatusViewController;

- (void) shortenLinks;
- (void) clearText;

- (void) beginLoadingForUserHeader;

@end

//
//	FLButtonbarToolbar.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/20/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLButtonbarView.h"
#import "FLToolbarButtonbarView.h"

// THIS IS DEPRECATED

@interface FLButtonbarToolbar : UIToolbar {
@private
	FLButtonbarView* _buttonbar;
}

- (id) initWithFrame:(CGRect)frame buttonbarView:(FLButtonbarView*) buttonBarView;

@property (readonly, retain, nonatomic) FLButtonbarView* buttonbar;

@end
//
//	FLDeprecatedButtonbarToolbar.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/20/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLDeprecatedButtonbarView.h"
#import "FLToolbarButtonbarView.h"

// THIS IS DEPRECATED

@interface FLDeprecatedButtonbarToolbar : UIToolbar {
@private
	FLDeprecatedButtonbarView* _buttonbar;
}

- (id) initWithFrame:(CGRect)frame buttonbarView:(FLDeprecatedButtonbarView*) buttonBarView;

@property (readonly, retain, nonatomic) FLDeprecatedButtonbarView* buttonbar;

@end
//
//	FLDeprecatedButtonbarToolbar.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/20/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
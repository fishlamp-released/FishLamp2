//
//	GtButtonbarToolbar.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/20/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtButtonbarView.h"
#import "GtToolbarButtonbarView.h"

@interface GtButtonbarToolbar : UIToolbar {
@private
	GtButtonbarView* m_buttonbar;
}

- (id) initWithFrame:(CGRect)frame buttonbarView:(GtButtonbarView*) buttonBarView;

@property (readonly, retain, nonatomic) GtButtonbarView* buttonbar;

@end
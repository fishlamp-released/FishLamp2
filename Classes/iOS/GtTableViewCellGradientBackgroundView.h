//
//	GtTableViewCellGradientBackgroundView.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/12/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtGradientView.h"

@interface GtTableViewCellGradientBackgroundView : GtGradientView {
@private
	BOOL m_drawDisclosureArrow;
	UIColor* m_arrowColor;
	CGFloat m_arrowAlpha;
}
@property (readwrite, assign, nonatomic) BOOL drawDisclosureArrow;
@property (readwrite, retain, nonatomic) UIColor* arrowColor;
@property (readwrite, assign, nonatomic) CGFloat arrowAlpha;
@end

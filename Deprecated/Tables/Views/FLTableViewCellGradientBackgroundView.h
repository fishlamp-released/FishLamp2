//
//	FLTableViewCellGradientBackgroundView.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/12/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLGradientView.h"

@interface FLTableViewCellGradientBackgroundView : FLGradientView {
@private
	BOOL _drawDisclosureArrow;
	UIColor* _arrowColor;
	CGFloat _arrowAlpha;
}
@property (readwrite, assign, nonatomic) BOOL drawDisclosureArrow;
@property (readwrite, retain, nonatomic) UIColor* arrowColor;
@property (readwrite, assign, nonatomic) CGFloat arrowAlpha;
@end

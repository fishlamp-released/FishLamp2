//
//	FLTableViewCellGradientBackgroundView.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/12/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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

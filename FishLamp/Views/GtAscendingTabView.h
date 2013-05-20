//
//  GtDescendingTabView.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/4/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#if IPHONE

#import "GtRoundRectView.h"
#import "GtViewUtilities.h"
#import "GtGeometry.h"

@interface GtAscendingTabView : UIView {
@private
	UILabel* m_line1;
	UILabel* m_line2;
	
	CGFloat m_backgroundOpacity;
	CGFloat m_borderOpacity;
	
	NSInteger m_topAdjust;
}

@property (readwrite, assign, nonatomic) NSInteger topAdjust;

@property (readwrite, assign, nonatomic) UILabel* line1;
@property (readwrite, assign, nonatomic) UILabel* line2;

@end
#endif